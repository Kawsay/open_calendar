class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :team_memberships, class_name: 'TeamMember', foreign_key: :user_id
  has_many :teams, through: :team_memberships
  has_many :calendars, through: :teams

  validates_presence_of :email

  self.implicit_order_column = 'created_at'

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

  def admin?
    false
  end
end
