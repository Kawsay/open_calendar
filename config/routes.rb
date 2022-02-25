Rails.application.routes.draw do
  root to: 'teams#show'

  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  devise_for :users

  resources :teams do
    resources :calendars
  end
  resources  :organizations, :events

  get 'events_modal/:id', to: 'events#_show_modal', as: 'events_modal'

  # Errors
  get '/401', to: 'application#page_unauthorized', as: :page_unauthorized
end
