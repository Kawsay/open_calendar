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
#  is_related_to_a_user :boolean          default(FALSE)
#  calendar_id          :bigint           not null
#
require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it 'is invalid without a title' do
      event = Fabricate.build(:event, title: nil)
      event.valid?
      expect(event).to model_have_error_on_field(:title)
    end

    it 'is invalid without belonging to a calendar' do
      event = Fabricate.build(:event, calendar: nil)
      event.valid?
      expect(event).to model_have_error_on_field(:calendar_id)
    end
  end

  describe 'scopes' do
    describe 'future' do
      it 'returns an array of future events' do
        future_event = Fabricate(:event, start_date: DateTime.now + 1)
        future_event.valid?
        expect(Event.future).to match_array([future_event])
      end
    end

    describe 'past' do
      it 'returns an array of past events' do
        past_event = Fabricate(:event, start_date: DateTime.now - 1)
        past_event.valid?
        expect(Event.past).to match_array([past_event])
      end
    end
  end
end
