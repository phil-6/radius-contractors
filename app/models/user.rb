class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :first_name, :last_name, :email, presence: true
  normalizes :email, with: ->(email) { email.downcase.strip }

  has_many :connections_as_a, class_name: "Connection", foreign_key: "user_a_id", dependent: :destroy
  has_many :connections_as_b, class_name: "Connection", foreign_key: "user_b_id", dependent: :destroy
  has_many :connections, ->(user) { unscope(:where).where("user_a_id = ? OR user_b_id = ?", user.id, user.id) }, class_name: "Connection"

  # Leaving some options here for future consideration
  # def connected_users
  #   user_a_ids = connections.select(:user_a_id)
  #   user_b_ids = connections.select(:user_b_id)
  #   User.where(id: user_a_ids).or(User.where(id: user_b_ids)).distinct
  # end
  def connected_users
    User.joins("INNER JOIN (
                SELECT user_a_id AS user_id FROM connections WHERE user_b_id = #{self.id}
                UNION
                SELECT user_b_id AS user_id FROM connections WHERE user_a_id = #{self.id}
              ) AS user_connections ON users.id = user_connections.user_id")
        .distinct
  end

  # def connected_users
  #   user_ids = Connection.where("user_a_id = :id OR user_b_id = :id", id: self.id)
  #                        .select("CASE WHEN user_a_id = #{self.id} THEN user_b_id ELSE user_a_id END AS user_id")
  #   User.where(id: user_ids).distinct
  # end

  def connected_with?(other_user)
    connected_users.exists?(other_user.id)
  end

  def create_connection_with(user_b)
    connections_as_a.create!(user_b:)
  end

  def connected_user_ids_and_self
    connected_users.pluck(:id) + [ id ]
  end

  has_many :jobs, dependent: :nullify
  has_many :used_contractors, through: :jobs, source: :contractor
  has_many :added_contractors, foreign_key: "added_by_id", dependent: :nullify, class_name: "Contractor"
  has_many :ratings, dependent: :nullify
  has_many :rated_contractors, through: :ratings, source: :contractor

  def contractors_rated_by_connections
    Contractor.joins(:ratings).where(ratings: { user_id: connected_users.select(:id) }).distinct
  end

  def viewable_contractors
    Contractor.where(id: added_contractors.select(:id))
              .or(Contractor.where(id: contractors_rated_by_connections.select(:id)))
              .distinct
  end

  # Maybe for Future
  # def second_degree_connections
  #   User.joins(:connections)
  #       .where(connections: { user_a_id: connected_users.select(:id) })
  #       .or(User.joins(:connections).where(connections: { user_b_id: connected_users.select(:id) }))
  #       .distinct
  # end
  #
  # def contractors_rated_by_connections
  #   first_degree_ids = connected_users.select(:id)
  #   second_degree_ids = second_degree_connections.select(:id)
  #   all_ids = first_degree_ids.union(second_degree_ids)
  #
  #   Contractor.joins(:ratings).where(ratings: { user_id: all_ids }).distinct
  # end

  def full_name
    "#{first_name} #{last_name}"
  end
end
