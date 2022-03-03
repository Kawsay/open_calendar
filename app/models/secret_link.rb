class SecretLink < ApplicationRecord
  SLUG_VALIDATOR_REGEX = /\A[a-zA-Z0-9]{16}\z/

  belongs_to :user
  belongs_to :calendar

  validates_presence_of :slug, on: :create
  validates_uniqueness_of :slug, on: :create
  validates_length_of :slug, is: 16, on: :create
  validates_format_of :slug, with: SLUG_VALIDATOR_REGEX

  validates_presence_of :visit_count
  validates_numericality_of :visit_count

  validates_presence_of :validity_period
  validates_numericality_of :validity_period

  validates_presence_of :user_id
  validates_presence_of :calendar_id
end
