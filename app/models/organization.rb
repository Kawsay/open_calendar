# == Schema Information
#
# Table name: organizations
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Organization < ApplicationRecord
  has_many :events
  has_many :documents, as: :documentable
  has_many :comments, as: :commentable
end
