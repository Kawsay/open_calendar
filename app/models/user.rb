# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  id                     :uuid             not null, primary key
#  team_member_id         :bigint
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :adhesions, dependent: :destroy
  has_many :teams, through: :adhesions
  has_many :calendars, through: :teams
  has_many :secret_links, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :appointments, through: :invitations, foreign_key: :event_id, source: :event

  validates :email, presence: true

  after_create :set_gravatar_url

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

  private

  def set_gravatar_url
    update_attribute :gravatar_url, GravatarService.new(self.email).url
  end
end
