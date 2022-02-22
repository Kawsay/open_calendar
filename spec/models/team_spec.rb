require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'validations' do
    describe 'is invalid' do
      it 'without a name' do
        team = Fabricate.build(:team, name: nil)
        team.valid?
        expect(team).to model_have_error_on_field(:name)
      end
    end
  end

  describe 'scopes' do
    describe '#of_user(user)' do
      it 'returns a collection of teams of a user' do
        team = Fabricate(:team)
        user = Fabricate(:user)
        user.team_memberships.create(team: team)
        expect(Team.of_user(user)).to eq [team]
      end
    end
  end
end
