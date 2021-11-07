class Event < ApplicationRecord
  belongs_to :user
  has_many :documents, as: :documentable
  has_many :comments, as: :commentable

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
  
  private

  def format_date(date)
    date.strftime('%d/%m/%Y %H:%M')
  end
end
