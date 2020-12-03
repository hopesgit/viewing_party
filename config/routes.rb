Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'

  # Users
  get '/register', to: 'users#new'
  post '/register', to: 'users#create', as: 'users'
  get '/dashboard', to: 'dashboard#show'
  post '/dashboard', to: 'friendships#create'
  # Sessions
  post '/', to: 'sessions#create'

  # Movies
  get '/discover', to: 'discover#index'

end
