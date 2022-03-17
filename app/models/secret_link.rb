# frozen_string_literal: true

# == Schema Information
#
# Table name: secret_links
#
#  id              :bigint           not null, primary key
#  slug            :string(16)       not null
#  validity_period :integer          default(1), not null
#  visit_count     :integer          default(0), not null
#  calendar_id     :bigint           not null
#  user_id         :uuid             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class SecretLink < ApplicationRecord
  SLUG_VALIDATOR_REGEX = /\A[a-zA-Z0-9]{16}\z/

  belongs_to :user
  belongs_to :calendar

  validates :slug, presence: { on: :create }
  validates :slug, uniqueness: { on: :create }
  validates :slug, length: { is: 16, on: :create }
  validates :slug, format: { with: SLUG_VALIDATOR_REGEX }

  validates :visit_count, presence: true
  validates :visit_count, numericality: true

  validates :validity_period, presence: true
  validates :validity_period, numericality: true

  validates :user_id, presence: true
  validates :calendar_id, presence: true

  before_validation :set_slug

  delegate :url_helpers, to: 'Rails.application.routes'

  def set_slug
    loop do
      self.slug = SecureRandom.alphanumeric
      break unless SecretLink.where(slug: slug).exists?
    end
  end

  def url
    "#{url_helpers.root_url}calendars/#{slug}"
  end
end
