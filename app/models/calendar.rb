# frozen_string_literal: true

# == Schema Information
#
# Table name: calendars
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  background_color :string(7)
#  text_color       :string
#  team_id          :bigint           default(75), not null
#
class Calendar < ApplicationRecord
  include Colorable
  include PgSearch::Model

  NAME_VALIDATOR_REGEX     = /\A[\w\s,.:?!'\-_]+\z/
  BG_COLOR_VALIDATOR_REGEX = /\A#[0-9a-fA-F]{6}\z/

  has_many :events, dependent: :destroy
  belongs_to :team
  has_many :users, through: :team
  has_many :secret_links, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { scope: :team_id, case_sensitive: false }
  validates :name, format: { with: NAME_VALIDATOR_REGEX }
  validates :background_color, uniqueness: { scope: :team_id, case_sensitive: false }
  validates :background_color, format: { with: BG_COLOR_VALIDATOR_REGEX }
  validates :text_color, inclusion: { in: %w[dark white] }

  before_validation :set_text_color

  scope :of_user, ->(user) { where(team: user.teams) }

  multisearchable(
    against:   [:name],
    update_if: :name_changed?
  )

  private

  def set_text_color
    self.text_color = background_color_is_too_dark? ? 'white' : 'dark'
  end
end
