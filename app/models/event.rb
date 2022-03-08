class Event < ApplicationRecord
  belongs_to :calendar, optional: true
  has_one :team, through: :calendar, source: :team
  belongs_to :organization, optional: true

  accepts_nested_attributes_for :organization

  has_rich_text :description

  scope :of_calendars, ->(calendars) { where(calendar: calendars) }
  scope :of_team, ->(team_name) { joins(calendar: :team).where(team: { name: team_name }) }
  scope :future, -> { where('start_date >= ?', DateTime.now) }
  scope :past, -> { where('start_date < ?', DateTime.now) }
  scope :after, ->(date) { where('start_date >= ?', date) }
  scope :before, ->(date) { where('start_date < ?', date) }
  scope :between_dates, ->(start_date, end_date) { after(start_date).before(end_date) }

  validates_presence_of :title
  validates_presence_of :calendar_id
  validates_presence_of :start_date

  def truncated_description(word_count: 5)
    description.split(/\s+/, word_count + 1)[0...word_count].append('...').join(' ')
  end

  # TODO: I18n
  def date
    if end_date.nil?
      "Le #{format_date(start_date)}"
    else
      "Du #{format_date(start_date)} au #{format_date(end_date)}"
    end
  end

  # Set :end_date from Flatpickr String date if a range date is passed
  def check_for_range_date!
    binding.pry
  end

  private

    def format_date(date)
      date.strftime('%d/%m/%Y %H:%M')
    end
end
