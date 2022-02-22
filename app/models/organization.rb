class Organization < ApplicationRecord
  has_one :contact
  has_many :events
  has_many :documents, as: :documentable
  has_many :comments, as: :commentable
end
