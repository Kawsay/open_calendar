require 'rails_helper'

describe EventPolicy do
  subject { described_class.new(user, event) }

  context 'when user is a visitor' do
    let(:user)  { nil }
    let(:event) { Fabricate(:event) }

    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'when user belongs to the calendar\'s team' do
    let(:user)     { Fabricate(:user, adhesions: [team.adhesions.build]) }
    let(:team)     { Fabricate(:team) }
    let(:calendar) { Fabricate(:calendar, team: team) }
    let(:event)    { Fabricate(:event, calendar: calendar) }

    before(:each) do
      # Definitly not the best way to handle bi-directionnal relations
      # in Fabricate
      # https://fabricationgem.org/#defining-fabricators
      team.calendars << calendar
    end

    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:destroy) }
  end

  context 'when user does not belong to the calendar\'s team' do
    let(:user)     { Fabricate(:user, adhesions: [team.adhesions.build]) }
    let(:team)     { Fabricate(:team) }
    let(:calendar) { Fabricate(:calendar, team: team) }
    let(:event)    { Fabricate(:event) }

    before(:each) do
      team.calendars << calendar
    end

    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'when user does not belong to any team' do
    let(:user) { Fabricate(:user) }
    let(:event) { Fabricate(:event) }

    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'when user\'s team has no calendar' do
    let(:user)  { Fabricate(:user, adhesions: [team.adhesions.build]) }
    let(:team)  { Fabricate(:team) }
    let(:event) { Fabricate(:event) }

    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:destroy) }
  end
end
