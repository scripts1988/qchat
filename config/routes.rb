Rails.application.routes.draw do
  resources :friendships
  resources :messages
  resources :sessions, only: [:new, :create]

  resources :users 
  root 'home#index'

  delete  'log_out' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
