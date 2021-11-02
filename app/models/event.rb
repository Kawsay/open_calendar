class Event < ApplicationRecord
  belongs_to :user
  has_many :documents, as: :documentable
  has_many :comments, as: :commentable

  def truncated_description(word_count: 8)
    description.split(/\s+/, word_count + 1)[0...word_count].append('...').join(' ')
  end
end
