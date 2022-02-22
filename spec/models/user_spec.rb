require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    describe 'is invalid' do
      it 'without a email' do
        user = Fabricate.build(:user, email: nil)
        user.valid?
        expect(user).to model_have_error_on_field(:email)
      end

      it 'without a password' do
        user = Fabricate.build(:user, password: nil)
        user.valid?
        expect(user).to model_have_error_on_field(:password)
      end

      it 'without a valid email' do
        user = Fabricate.build(:user, email: 'no_a_valid_email')
        user.valid?
        expect(user).to model_have_error_on_field(:email)
      end

      it 'without a valid password' do
        user = Fabricate.build(:user, password: 'short')
        user.valid?
        expect(user).to model_have_error_on_field(:password)
      end
    end
  end

  describe 'associations' do
    it 'has_many :team_memberships' do
      user            = Fabricate(:user)
      team_membership = Fabricate(:team_member, user: user)
      expect(user.team_memberships).to eq [team_membership]
    end

    it 'has_many :teams' do
      team = Fabricate(:team)
      user = Fabricate(:user)
      user.team_memberships.create!(team: team)
      expect(user.teams).to eq [team]
    end

    it 'has_many :calendars through: :teams' do
      user     = Fabricate(:user)
      team     = Fabricate(:team)
      calendar = Fabricate(:calendar, team: team)
      user.team_memberships.create!(team: team)
      expect(user.calendars).to eq [calendar]
    end

  end
end
