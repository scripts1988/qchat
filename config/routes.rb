Rails.application.routes.draw do
  resources :messages
  resources :sessions, only: [:new, :create]

  resources :users 
  root 'home#index'

  delete  'log_out' => 'sessions#destroy'
  post    'add_friend' => 'users#add_friend'
  get     'sent_messages' => 'messages#sent'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
