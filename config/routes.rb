# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'teams#show'

  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  namespace :api do
    namespace :v1 do
      resources :events, only: %i[index]
    end
  end

  devise_for :users

  get '/calendars/:slug', to: 'secret_links#show', constraint: { slug: /\A[a-zA-Z0-9]{16}\z/ }

  resources :teams do
    resources :calendars do
      resources :events, shallow: true
    end
  end

  resources :organizations
  resources :secret_links, only: %i[create]

  post 'reset_teams', to: 'teams#destroy_all', as: 'reset_team'
  get 'events_modal/:id', to: 'events#_show_modal', as: 'events_modal'

  # Errors
  get '/401', to: 'application#page_unauthorized', as: :page_unauthorized
end
