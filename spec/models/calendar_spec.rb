# frozen_string_literal: true

# == Schema Information
#
# Table name: calendars
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  background_color :string(7)
#  text_color       :string
#  team_id          :bigint           default(75), not null
#
require 'rails_helper'

RSpec.describe Calendar, type: :model do
  let(:calendar) { Fabricate(:calendar) }

  describe 'validations' do
    describe 'is invalid' do
      let(:team) { Fabricate(:team) }

      it 'without a name' do
        calendar = Fabricate.build(:calendar, name: nil)
        calendar.valid?
        expect(calendar).to model_have_error_on_field(:name)
      end

      it 'without a background_color' do
        calendar = Fabricate.build(:calendar, background_color: nil)
        calendar.valid?
        expect(calendar).to model_have_error_on_field(:background_color)
      end

      it 'with a non-uniq name if belong to the same team' do
        calendar_1 = Fabricate(:calendar, name: 'non uniq', team: team)
        calendar_2 = Fabricate.build(:calendar, name: 'non uniq', team: team)
        calendar_2.valid?
        expect(calendar_2).to model_have_error_on_field(:name)
      end

      it 'with a name containing non-authorized characters' do
        calendar = Fabricate.build(:calendar, name: 'not_v@lid')
        calendar.valid?
        expect(calendar).to model_have_error_on_field(:name)
      end

      it 'with a non-uniq background_color if belong to the same team' do
        calendar_1 = Fabricate(:calendar, background_color: '#000000', team: team)
        calendar_2 = Fabricate.build(:calendar, background_color: '#000000', team: team)
        calendar_2.valid?
        expect(calendar_2).to model_have_error_on_field(:background_color)
      end

      it 'with a non-hexadecimal background_color format' do
        calendar = Fabricate.build(:calendar, background_color: 'not hexa')
        calendar.valid?
        expect(calendar).to model_have_error_on_field(:background_color)
      end
    end
  end

  describe 'scopes' do
  end

  describe '#create' do
    it 'set dark text_color for light background_color' do
      calendar = Fabricate(:calendar, background_color: '#FFFFFF')
      expect(calendar.text_color).to eq 'dark'
    end

    it 'set white text_color for dark background_color' do
      calendar = Fabricate(:calendar, background_color: '#000000')
      expect(calendar.text_color).to eq 'white'
    end

    it 'set text_color value included in ["white", "black"]' do
      expect { should validate_inclusion_of(:text_color).in?(%w[white black]) }
    end
  end
end
