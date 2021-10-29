Rails.application.routes.draw do
  devise_for :administrators

  root to: 'calendars#index'

  resources :comments, :documents, :events, :contacts, :users
end
