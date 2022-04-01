# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id                   :bigint           not null, primary key
#  start_date           :datetime
#  end_date             :datetime
#  location             :text
#  description          :text
#  organization_id      :bigint
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  title                :string
#  calendar_id          :bigint           not null
#
class Event < ApplicationRecord
  belongs_to :calendar, optional: true
  has_one :team, through: :calendar, source: :team
  belongs_to :organization, optional: true
  has_many :comments, as: :commentable
  has_many :invitations, dependent: :destroy
  has_many :attendees, through: :invitations, class_name: 'User', foreign_key: :user_id, source: :user

  accepts_nested_attributes_for :organization

  has_rich_text :description

  scope :of_team, ->(team_name) { where(team: { name: team_name }) }
  scope :future, -> { where('start_date >= ?', DateTime.now) }
  scope :past, -> { where('start_date < ?', DateTime.now) }
  scope :after, ->(date) { where('start_date >= ?', date) }
  scope :before, ->(date) { where('start_date < ?', date) }
  scope :between_dates, ->(start_date, end_date) { after(start_date).before(end_date) }

  validates :title, presence: true
  validates :calendar_id, presence: true
  validates :start_date, presence: true

  self.implicit_order_column = 'created_at'
end
