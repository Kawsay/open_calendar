class Calendar < ApplicationRecord
  include Colorable

  has_many :events, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :background_color, format: { with: /\A#[0-9a-f]{6}\z/ }
  validates :text_color, inclusion: { in: ['dark', 'white'] }

  before_validation :set_text_color

  private

  def set_text_color
    self.text_color = self.background_color_is_too_dark? ? 'white' : 'dark'
  end
end
