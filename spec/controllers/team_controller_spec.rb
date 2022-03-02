require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe '#show' do
    let!(:user) { Fabricate(:user) }

    context 'when @teams.blank?' do
      before(:each) do
        sign_in(user)
        get :show
      end

      it { expect(assigns(:team)).not_to be_nil }
      it { expect(assigns(:team)).to be_a_new Team }
      it { expect(assigns(:teams)).to be_empty }
      it { expect(assigns(:new_calendar)).to be_nil }
      it { expect(assigns(:current_team)).to be_nil }
      it { expect(assigns(:organizations)).to be_nil }
      it { is_expected.to render_template('new') }
      it { expect(response).to have_http_status 200 }
    end

    context 'when Calendar.of_teams(@teams).blank?' do
      let!(:adhesion) { Fabricate(:adhesion, user: user, team: Fabricate(:team)) }

      before(:each) do
        sign_in(user)
        get :show
      end

      it { expect(assigns(:teams)).not_to be_nil }
      it { expect(assigns(:teams)).not_to be_empty }
      it { expect(assigns(:teams)).to eq(user.teams) }
      it { expect(assigns(:current_team)).not_to be_nil }
      it { expect(assigns(:current_team)).to eq(user.favorite_team) }
      it { expect(assigns(:new_calendar)).not_to be_nil }
      it { expect(assigns(:new_calendar)).to be_a_new Calendar }
      it { expect(assigns(:organizations)).not_to be_nil }
      it { expect(assigns(:organizations)).to eq(Organization.of_team(assigns(:current_team))) }
      it { is_expected.to render_template('calendars/new') }
      it { expect(response).to have_http_status 200 }
    end

    context 'when user has calendars' do
      let!(:team)     { Fabricate(:team) }
      let!(:adhesion) { Fabricate(:adhesion, user: user, team: team) }
      let!(:calendar) { Fabricate(:calendar, team: team) }
      let(:event)     { Fabricate(:event, calendar: calendar) }

      before(:each) do
        sign_in(user)
        get :show
      end

      it { expect(assigns(:teams)).not_to be_nil }
      it { expect(assigns(:teams)).not_to be_empty }
      it { expect(assigns(:teams)).to eq([team]) }
      it { expect(assigns(:current_team)).to eq(user.favorite_team) }
      it { expect(assigns(:calendars)).not_to be_nil }
      it { expect(assigns(:calendars)).to eq([calendar]) }
      it { expect(assigns(:events)).not_to be_nil }
      it { expect(assigns(:events)).to eq([event]) }
      it { is_expected.to render_template('calendars/index') }
      it { expect(response).to have_http_status 200 }
    end

    context 'when a team is selected' do
    end
  end

  describe '#create' do
    let(:user) { Fabricate(:user) }
    let(:valid_params) { { team: { name: 'Whatateam' } } }
    let(:invalid_params) { { team: { name: '' } } }

    context 'when success' do
      before(:each) do
        sign_in(user)
        post :create, params: valid_params
      end

      it { expect(assigns(:team).persisted?).to be true }
      it { expect(assigns(:team).adhesions).to eq(user.adhesions) }
      it { expect(response.status).to eq(302) }
      it { expect(response.headers['Location']).to match(/\/teams\/\d+\z/) }

      # TODO: Find a way to test TURBO_STREAM responses
      # it 'reponds to TURBO_STREAM format' do
      #   post :create, params: { team: { name: 'Whatateam' }, headers: :turbo_stream_headers }
      #   expect(response.content_type).to eq('')
      # end
    end

    context 'when user is not logged in' do
      before(:each) do
        sign_out(user)
        post :create, params: valid_params
      end

      it { expect(assigns(:team)).to be_nil }
      it { expect(assigns(:team)&.persisted?).to be_nil }
      it { expect(assigns(:team)&.adhesions).to be_nil }
      it { expect(response.headers['Location']).to match(/\/401\Z/) }
    end

    context 'when invalid parameters' do
      before(:each) do
        sign_in(user)
        post :create, params: invalid_params
      end

      it { expect(assigns(:team).persisted?).to be false }
      it { expect(assigns(:team).adhesions.first.persisted?).to be false }
      it { expect(assigns(:team)&.adhesions.first).to be_a_new Adhesion}
      it { expect(response).to have_http_status 422 }
      it { expect(response).to render_template('teams/new') }
    end
  end
end
