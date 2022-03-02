class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :adhesions, dependent: :destroy
  has_many :teams, through: :adhesions
  has_many :calendars, through: :teams

  validates_presence_of :email

  self.implicit_order_column = 'created_at'

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

  def favorite_team
    teams.favorite
  end

  def admin?
    false
  end
end
