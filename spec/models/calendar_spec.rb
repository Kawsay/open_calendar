require 'rails_helper'

RSpec.describe Calendar, type: :model do
  let(:calendar) { Fabricate(:calendar) }

  describe '#new' do
    subject { Calendar.new(name: Faker::Name.name, background_color: Faker::Color.hex_color) }

    context 'when resource is valid' do
      it 'has a name' do
        expect(subject.name).to be_truthy
      end

      it 'has a uniq name' do
        should validate_uniqueness_of(:name).case_insensitive
      end

      it 'has a String name' do
        expect(subject.name).to be_instance_of(String)
      end

      it 'has a name matching only letters, digits, spaces, or .,:?!\'' do
        expect(subject.name).to match Calendar::NAME_VALIDATOR_REGEX
      end

      it 'has a background_color' do
        expect(subject.background_color).to be_truthy
      end

      it 'has a uniq background_color' do
        should validate_uniqueness_of(:background_color).case_insensitive
      end

      it 'has a String background_color' do
        expect(subject.background_color).to be_instance_of(String)
      end

      it 'has a background_color matching "#" followed by 6 characters from 0 to F' do
        expect(subject.background_color).to match Calendar::BG_COLOR_VALIDATOR_REGEX
      end

      it 'does not have a text_color' do
        expect(subject.text_color).to be_nil
      end

      it 'is valid with only :name and :background_color set' do
        expect(subject).to be_valid
      end
    end

    context 'when resource is not valid' do
      # TEST INVALIDITY HERE
    end
  end

  describe '#create' do
    context 'when resource is valid' do
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

    context 'when resource is not valid' do
      # TEST INVALIDITY HERE
    end
  end
end
