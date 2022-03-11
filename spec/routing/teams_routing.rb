require 'rails_helper'

describe 'routing to teams' do
  let(:team) { Fabricate(:team) }

  it 'routes GET / to teams#show' do
    expect(get: '/').to route_to(
      controller: 'teams',
      action:     'show'
    )
  end

  it 'routes GET /teams to teams#index' do
    expect(get: '/teams').to route_to(
      controller: 'teams',
      action:     'index'
    )
  end

  it 'routes GET /teams/:id to teams#show' do
    expect(get: "/teams/#{team.id}").to route_to(
      controller: 'teams',
      action:     'show',
      id:         team.id.to_s
    )
  end

  it 'routes GET /teams/new to teams#new' do
    expect(get: '/teams/new').to route_to(
      controller: 'teams',
      action:     'new'
    )
  end

  it 'routes GET /teams/:id/edit to teams#edit' do
    expect(get: "/teams/#{team.id}/edit").to route_to(
      controller: 'teams',
      action:     'edit',
      id:         team.id.to_s
    )
  end

  it 'routes POST /teams to teams#create' do
    expect(post: '/teams').to route_to(
      controller: 'teams',
      action:     'create'
    )
  end

  it 'routes PATCH /teams/:id to teams#update' do
    expect(patch: "/teams/#{team.id}").to route_to(
      controller: 'teams',
      action:     'update',
      id:         team.id.to_s
    )
  end

  it 'routes PUT /teams/:id to teams#update' do
    expect(put: "/teams/#{team.id}").to route_to(
      controller: 'teams',
      action:     'update',
      id:         team.id.to_s
    )
  end

  it 'routes DELETE /teams/:id to teams#destroy' do
    expect(delete: "/teams/#{team.id}").to route_to(
      controller: 'teams',
      action:     'destroy',
      id:         team.id.to_s
    )
  end
end
