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
    resources :calendars
  end

  resources :events do
    resources :comments, module: :events
  end

  resources :comments do
    resources :comments, module: :comments
  end

  resources :organizations, only: %i[create]
  resources :secret_links, only: %i[create]

  post '/search', to: 'search#search'

  #
  # Errors
  #
  get '/401', to: 'application#page_unauthorized', as: :page_unauthorized
end
