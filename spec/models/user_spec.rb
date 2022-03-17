# == Schema Information
#
# Table name: users
#
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  id                     :uuid             not null, primary key
#  team_member_id         :bigint
#
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
    it 'has_many :adhesions' do
      user     = Fabricate(:user)
      adhesion = Fabricate(:adhesion, user: user)
      expect(user.adhesions).to eq [adhesion]
    end

    it 'has_many :teams' do
      team = Fabricate(:team)
      user = Fabricate(:user)
      user.adhesions.create!(team: team)
      expect(user.teams).to eq [team]
    end

    it 'has_many :calendars through: :teams' do
      user     = Fabricate(:user)
      team     = Fabricate(:team)
      calendar = Fabricate(:calendar, team: team)
      user.adhesions.create!(team: team)
      expect(user.calendars).to eq [calendar]
    end
  end

  context 'class methods' do
    describe '.authenticate' do
      it 'finds returns a User if #valid_password?' do
        user = Fabricate(:user, email: 'foo@bar.com', password: 'foobar')
        expect(User.authenticate('foo@bar.com', 'foobar')).to eq user
      end
    end
  end

  context 'instance methods' do
    describe '#favorite_team' do
      it 'returns user\'s favorite team' do
        user = Fabricate(:user)
        team = Fabricate(:team, adhesions: [user.adhesions.build])
        expect(user.favorite_team).to eq team
      end
    end

    describe '#admin?' do
      # it 'returns true if user is an admin' do
      #   user = Fabricate(:user, admin: true)
      #   expect(user.admin?).to be_truthy
      # end

      # it 'returns false if user is not an admin' do
      #   user = Fabricate(:user, admin: false)
      #   expect(user.admin?).to be_falsey
      # end

      it 'returns true/false if user is admin' do
        user = Fabricate(:user)
        expect(user.admin?).to be_falsey
      end
    end
  end
end
