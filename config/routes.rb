Rails.application.routes.draw do
  devise_for :administrators

  root to: 'calendars#index'

  resources :calendars, :contacts, :comments, :documents, :events, :users

  get 'events_modal/:id', to: 'events#_show_modal', as: 'events_modal'
end
