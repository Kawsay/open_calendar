# frozen_string_literal: true

require 'rails_helper'

describe TeamPolicy do
  subject { described_class.new(user, team) }

  context 'when user is a visitor' do
    let(:user) { nil }
    let(:team) { Fabricate(:team) }

    it { is_expected.to forbid_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'when user belongs to the team' do
    let(:user) { Fabricate(:user, adhesions: [team.adhesions.build]) }
    let(:team) { Fabricate(:team) }

    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to forbid_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:destroy) }
  end

  context 'when user does not belongs to the team' do
    let(:user) { Fabricate(:user) }
    let(:team) { Fabricate(:team) }

    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to forbid_edit_and_update_actions }
    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:destroy) }
  end
end
