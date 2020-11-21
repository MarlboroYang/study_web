Rails.application.routes.draw do
  root 'boards#index'

  get '/users/sign_up', to: 'registrations#new', as: 'registration'
  post '/users', to: 'registrations#create'

  get '/users/sign_in', to: 'sessions#new', as: 'session'
  post '/login', to: 'sessions#create', as: 'login'

  delete '/users/sign_out', to: 'sessions#destroy', as: 'logout'

  resources :boards
end