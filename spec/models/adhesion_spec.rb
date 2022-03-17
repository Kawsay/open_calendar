# frozen_string_literal: true

# == Schema Information
#
# Table name: adhesions
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid
#  team_id    :bigint
#
require 'rails_helper'

RSpec.describe Adhesion, type: :model do
  describe 'validations' do
    describe 'is invalid' do
      it 'without a user' do
        adhesion = Fabricate.build(:adhesion, user: nil)
        adhesion.valid?
        expect(adhesion).to model_have_error_on_field(:user)
      end

      it 'without a team' do
        adhesion = Fabricate.build(:adhesion, team: nil)
        adhesion.valid?
        expect(adhesion).to model_have_error_on_field(:team)
      end
    end
  end
end
