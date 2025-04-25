class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :first_name, :last_name, :email, presence: true
  normalizes :email, with: ->(email) { email.downcase.strip }

  has_many :connections_as_a, class_name: "Connection", foreign_key: "user_a_id", dependent: :destroy, inverse_of: :user_a
  has_many :connections_as_b, class_name: "Connection", foreign_key: "user_b_id", dependent: :destroy, inverse_of: :user_b
  has_many :connections, ->(user) { unscope(:where).where("user_a_id = ? OR user_b_id = ?", user.id, user.id) }, class_name: "Connection" # rubocop:disable Rails/InverseOf, Rails/HasManyOrHasOneDependent

  has_many :jobs, dependent: :nullify
  has_many :used_contractors, through: :jobs, source: :contractor
  has_many :added_contractors, foreign_key: "added_by_id", dependent: :nullify, class_name: "Contractor", inverse_of: :added_by
  has_many :ratings, dependent: :nullify
  has_many :rated_contractors, through: :ratings, source: :contractor
  # Leaving some options here for future consideration
  # def connected_users
  #   user_a_ids = connections.select(:user_a_id)
  #   user_b_ids = connections.select(:user_b_id)
  #   User.where(id: user_a_ids).or(User.where(id: user_b_ids)).distinct
  # end
  # def connected_users
  #   user_ids = Connection.where("user_a_id = :id OR user_b_id = :id", id: self.id)
  #                        .select("CASE WHEN user_a_id = #{self.id} THEN user_b_id ELSE user_a_id END AS user_id")
  #   User.where(id: user_ids).distinct
  # end
  def connected_users
    User.joins("INNER JOIN (
                SELECT user_a_id AS user_id FROM connections WHERE user_b_id = #{id}
                UNION
                SELECT user_b_id AS user_id FROM connections WHERE user_a_id = #{id}
              ) AS user_connections ON users.id = user_connections.user_id")
        .distinct
  end

  def connected_with?(other_user)
    connected_users.exists?(other_user.id)
  end

  def create_connection_with(user_a)
    connections_as_b.create(user_a:)
  end

  def network_ids_and_self
    ids = direct_connected_user_ids + [ id ]
    ids += second_degree_connected_ids if second_degree_connections_enabled
    ids.uniq
  end

  def direct_connected_user_ids
    connected_users.pluck(:id)
  end

  def second_degree_connected_ids
    second_degree_connections.pluck(:id)
  end

  def second_degree_connections_through(other_user)
    other_user.direct_connected_user_ids - connected_users.pluck(:id) - [ id ]
  end

  def connection_link(host, port = nil)
    Rails.application.routes.default_url_options[:host] ||= host
    Rails.application.routes.default_url_options[:port] ||= port
    Rails.application.routes.url_helpers.new_connection_url(user_a_id: id)
  end

  def contractors_rated_by_connections
    Contractor.joins(:ratings)
              .where(ratings: { user_id: connected_users.select(:id) })
              .distinct
  end

  # Maybe for Future
  def second_degree_connections
    direct_ids = connected_users.pluck(:id)
    return User.none if direct_ids.empty?

    User.joins("INNER JOIN (SELECT user_a_id AS user_id FROM connections
    WHERE user_b_id IN (#{direct_ids.join(',')})
    UNION SELECT user_b_id AS user_id FROM connections
    WHERE user_a_id IN (#{direct_ids.join(',')}))
    AS user_connections ON users.id = user_connections.user_id")
        .where.not(id: direct_ids + [ id ])
        .distinct
  end

  def contractors_rated_by_second_degree_connections
    Contractor.joins(:ratings)
              .where(ratings: { user_id: second_degree_connections.select(:id) })
              .distinct
  end

  def viewable_contractors
    ids = (added_contractors.select(:id) +
      used_contractors.select(:id) +
      rated_contractors.select(:id) +
      contractors_rated_by_connections.select(:id))
    ids += contractors_rated_by_second_degree_connections.select(:id) if second_degree_connections_enabled
    Contractor.where(id: ids.uniq)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
