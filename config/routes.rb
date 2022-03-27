# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'teams#show'

  #
  # Authentication
  #
  devise_for :users

  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  #
  # API
  #
  namespace :api do
    namespace :v1 do
      resources :events, only: %i[index]
    end
  end

  #
  # Application
  #
  resources :teams do
    resources :calendars do
      resources :events, shallow: true
    end
  end

  resources :organizations, only: %i[create]
  resources :secret_links, only: %i[create]

  get '/events/:id/update_modal', to: 'events#update_modal'
  post 'reset_teams',             to: 'teams#destroy_all', as: 'reset_team' # TODO: remove before v0

  #
  # Errors
  #
  get '/401', to: 'application#page_unauthorized', as: :page_unauthorized
end
