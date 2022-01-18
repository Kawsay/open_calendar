Rails.application.routes.draw do
  devise_for :administrators

  root to: 'calendars#index'

  resources :calendars, :contacts, :comments, :documents, :events, :users, :event_types

  get 'add_event_modal',  to: 'events#_add_modal',  as: 'add_event_modal'
  get 'events_modal/:id', to: 'events#_show_modal', as: 'events_modal'

  # Errors
  get '/401', to: 'application#page_unauthorized', as: :page_unauthorized
end
