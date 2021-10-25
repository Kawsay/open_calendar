class Comment < ApplicationRecord
  belongs_to :administrator
  belongs_to :commentable, polymorphic: true
end
