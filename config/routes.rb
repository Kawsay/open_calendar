Rails.application.routes.draw do
  devise_for :administrators
  resources :comments
  resources :documents
  resources :events
  resources :contacts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
