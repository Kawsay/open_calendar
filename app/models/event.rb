class Event < ApplicationRecord
  belongs_to :user
  has_many :documents, as: :documentable
  has_many :comments, as: :commentable
end
