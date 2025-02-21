class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :first_name, :last_name, :email, presence: true
  normalizes :email, with: ->(email) { email.downcase.strip }

  has_many :connections_as_a, class_name: "Connection", foreign_key: "user_a_id", dependent: :destroy
  has_many :connections_as_b, class_name: "Connection", foreign_key: "user_b_id", dependent: :destroy

  # Single association that gets all connected users, no need to merge arrays
  has_many :connections, ->(user) { unscope(:where).where("user_a_id = ? OR user_b_id = ?", user.id, user.id) }, class_name: "Connection"

  has_many :connected_users, through: :connections, source: :user_a
  has_many :connected_users, through: :connections, source: :user_b

  def connected_with?(other_user)
    connected_users.exists?(other_user.id)
  end

  def create_connection_with(user_b)
    connections_as_a.create!(user_b:)
  end

  has_many :jobs, dependent: :nullify
  has_many :used_contractors, through: :jobs, source: :contractor
  has_many :added_contractors, foreign_key: "added_by_id", dependent: :nullify, class_name: "Contractor"
  has_many :ratings, dependent: :nullify
  has_many :rated_contractors, through: :ratings, source: :contractor

  def full_name
    "#{first_name} #{last_name}"
  end
end
