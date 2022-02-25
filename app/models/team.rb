class Team < ApplicationRecord
  has_many :adhesions, dependent: :destroy
  has_many :members, through: :memberships, source: :user
  has_many :calendars, dependent: :destroy

  validates_presence_of :name

  scope :of_user, ->(user) { where(adhesions: user.adhesions) }
  scope :by_favourite, -> { order(visit_count: :desc) }

  def self.user_favorite(user)
    of_user(user).by_favourite.first
  end
end
