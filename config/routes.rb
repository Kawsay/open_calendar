Rails.application.routes.draw do
  devise_for :administrators

  root to: 'calendars#index'

  resources :comments, :documents, :events, :contacts, :users

  get 'events_modal/:id', to: 'events#_show_modal', as: 'events_modal'
end
