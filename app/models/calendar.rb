class Calendar < ApplicationRecord
  include Colorable

  NAME_VALIDATOR_REGEX     = /\A[\w\s\,\.\:\?\!\'\-\_]+\z/
  BG_COLOR_VALIDATOR_REGEX = /\A#[0-9a-fA-F]{6}\z/

  has_many :events, dependent: :destroy
  belongs_to :team
  has_many :users, through: :team

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, format: { with: NAME_VALIDATOR_REGEX }
  validates :background_color, uniqueness: { case_sensitive: false }
  validates :background_color, format: { with: BG_COLOR_VALIDATOR_REGEX }
  validates :text_color, inclusion: { in: ['dark', 'white'] }

  before_validation :set_text_color

  scope :of_team, ->(team) { where(team: team) }
  scope :of_user, ->(user) { where(team: user.teams) }

  private

  def set_text_color
    self.text_color = self.background_color_is_too_dark? ? 'white' : 'dark'
  end
end
