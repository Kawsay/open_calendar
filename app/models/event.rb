class Event < ApplicationRecord
  belongs_to :calendar, optional: true
  has_one :team, through: :calendar, source: :team
  belongs_to :organization, optional: true

  accepts_nested_attributes_for :organization

  has_rich_text :description

  scope :of_team, ->(team_name) { where(team: { name: team_name }) }
  scope :future, -> { where('start_date >= ?', DateTime.now) }
  scope :past, -> { where('start_date < ?', DateTime.now) }
  scope :after, ->(date) { where('start_date >= ?', date) }
  scope :before, ->(date) { where('start_date < ?', date) }
  scope :between_dates, ->(start_date, end_date) { after(start_date).before(end_date) }

  validates_presence_of :title
  validates_presence_of :calendar_id
  validates_presence_of :start_date
end
