# frozen_string_literal: true

# == Schema Information
#
# Table name: documents
#
#  id                :bigint           not null, primary key
#  title             :text
#  description       :string
#  documentable_type :string           not null
#  documentable_id   :bigint           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Document < ApplicationRecord
  belongs_to :documentable, polymorphic: true
  has_many :comments, as: :commentable

  has_one_attached :file
end
