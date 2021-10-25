class User < ApplicationRecord
  has_one :contact
  has_many :events
  has_many :documents, as: :documentable
end
