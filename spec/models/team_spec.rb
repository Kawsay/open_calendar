# frozen_string_literal: true

# == Schema Information
#
# Table name: teams
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string           default(""), not null
#  visit_count :integer
#
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
    describe '.of_user(user)' do
      it 'returns a collection of teams of a user' do
        user = Fabricate(:user)
        team = Fabricate(:team, adhesions: [user.adhesions.build])
        expect(Team.of_user(user)).to eq [team]
      end
    end

    describe '.by_favorite' do
      it 'returns a collection of teams ordered by :visit_count' do
        t1 = Fabricate(:team, visit_count: 1)
        t2 = Fabricate(:team, visit_count: 2)
        expect(Team.by_favorite).to eq [t2, t1]
      end
    end

    describe '.favorite' do
      it 'returns the most visited team' do
        t1 = Fabricate(:team, visit_count: 1)
        t2 = Fabricate(:team, visit_count: 2)
        expect(Team.favorite).to eq t2
      end
    end
  end

  context 'class methods' do
  end
end
