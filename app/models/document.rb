class Document < ApplicationRecord
  belongs_to :documentable, polymorphic: true
  has_many :comments, as: :commentable

  has_one_attached :file
end
