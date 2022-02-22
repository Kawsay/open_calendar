require 'rails_helper'

RSpec.describe TeamMember, type: :model do
  describe 'validations' do
    describe 'is invalid' do
      it 'without a user' do
        team_member = Fabricate.build(:team_member, user: nil)
        team_member.valid?
        expect(team_member).to model_have_error_on_field(:user)
      end

      it 'without a team' do
        team_member = Fabricate.build(:team_member, team: nil)
        team_member.valid?
        expect(team_member).to model_have_error_on_field(:team)
      end
    end
  end
end
