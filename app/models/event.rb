class Event < ApplicationRecord
  belongs_to :user
  has_many :documents, as: :documentable
end
