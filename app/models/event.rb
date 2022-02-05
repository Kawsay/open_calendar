class Event < ApplicationRecord
  belongs_to :calendar
  belongs_to :user, optional: true
  has_many :documents, as: :documentable
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :documents, :user

  has_rich_text :description

  def truncated_description(word_count: 5)
    description.split(/\s+/, word_count + 1)[0...word_count].append('...').join(' ')
  end

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
