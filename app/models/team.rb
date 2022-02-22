class Team < ApplicationRecord
  has_many :memberships, dependent: :destroy, class_name: 'TeamMember'
  has_many :members, through: :memberships, class_name: 'User', source: :user
  has_many :calendars, dependent: :destroy

  validates_presence_of :name

  scope :of_user, ->(user) { where(memberships: user.team_memberships) }
end
