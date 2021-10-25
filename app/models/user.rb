class User < ApplicationRecord
  has_one :contact
  has_many :events
end
