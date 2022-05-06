# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'teams#show'

  #
  # Authentication / Authorization
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
  scope '/:locale' do
    resources :teams do
      resources :calendars, shallow: true
    end

    resources :events do
      resources :comments, module: :events
    end

    resources :comments do
      resources :comments, module: :comments
    end

    resources :organizations, only: %i[create]
    resources :share_links, only: %i[create]

    get '/calendars/shared/:token', to: 'share_links#authorize_request', constraints: { token: /[^\/]+/ }
  end

  post '/search', to: 'search#search'
end
