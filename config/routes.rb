Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  devise_for :users

  root to: 'calendars#index'

  resources :calendars, :comments, :documents, :events, :organizations, :event_types

  get 'events_modal/:id', to: 'events#_show_modal', as: 'events_modal'

  # Errors
  get '/401', to: 'application#page_unauthorized', as: :page_unauthorized
end
