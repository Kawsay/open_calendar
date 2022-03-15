class Team < ApplicationRecord
  has_many :adhesions, dependent: :destroy
  has_many :users, through: :adhesions
  has_many :calendars, dependent: :destroy, foreign_key: :team_id

  validates_presence_of :name

  scope :of_user, ->(user) { where(adhesions: user.adhesions) }
  scope :by_favorite, -> { order(visit_count: :desc) }
  scope :favorite, -> { order(visit_count: :desc).first }

  def self.user_favorite(user)
    of_user(user).by_favorite.first
  end
end
