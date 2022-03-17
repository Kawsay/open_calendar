# frozen_string_literal: true

require 'rails_helper'

describe 'routing to calendars' do
  let(:team)     { Fabricate(:team) }
  let(:calendar) { Fabricate(:calendar, team: team) }

  it 'routes GET /teams/:team_id/calendars to calendars#index' do
    expect(get: "/teams/#{team.id}/calendars").to route_to(
      controller: 'calendars',
      action: 'index',
      team_id: team.id.to_s
    )
  end

  it 'routes GET /teams/:team_id/calendars/:calendar_id to calendars#show' do
    expect(get: "/teams/#{team.id}/calendars/#{calendar.id}").to route_to(
      controller: 'calendars',
      action: 'show',
      team_id: team.id.to_s,
      id: calendar.id.to_s
    )
  end

  it 'routes GET /teams/:team_id/calendars/new to calendars#new' do
    expect(get: "/teams/#{team.id}/calendars/new").to route_to(
      controller: 'calendars',
      action: 'new',
      team_id: team.id.to_s
    )
  end

  it 'routes GET /teams/:team_id/calendars/:calendar_id/edit to calendars#edit' do
    expect(get: "/teams/#{team.id}/calendars/#{calendar.id}/edit").to route_to(
      controller: 'calendars',
      action: 'edit',
      team_id: team.id.to_s,
      id: calendar.id.to_s
    )
  end

  it 'routes POST /teams/:team_id/calendars to calendars#create' do
    expect(post: "/teams/#{team.id}/calendars").to route_to(
      controller: 'calendars',
      action: 'create',
      team_id: team.id.to_s
    )
  end

  it 'routes PATCH /teams/:team_id/calendars/:calendar_id to calendars#update' do
    expect(patch: "/teams/#{team.id}/calendars/#{calendar.id}").to route_to(
      controller: 'calendars',
      action: 'update',
      team_id: team.id.to_s,
      id: calendar.id.to_s
    )
  end

  it 'routes PUT /teams/:team_id/calendars/:calendar_id to calendars#update' do
    expect(put: "/teams/#{team.id}/calendars/#{calendar.id}").to route_to(
      controller: 'calendars',
      action: 'update',
      team_id: team.id.to_s,
      id: calendar.id.to_s
    )
  end

  it 'routes DELETE /teams/:team_id/calendars/:calendar_id to calendars#destroy' do
    expect(delete: "/teams/#{team.id}/calendars/#{calendar.id}").to route_to(
      controller: 'calendars',
      action: 'destroy',
      team_id: team.id.to_s,
      id: calendar.id.to_s
    )
  end
end
