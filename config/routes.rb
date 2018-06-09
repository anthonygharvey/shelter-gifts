Rails.application.routes.draw do
  get '/register' => 'users#new'
  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  
  resources :users do
    resources :shelters, shallow: true do
      resources :lists, shallow: true do
      end
    end
  end
  resources :items, only: [:index]

  root 'items#index'

end
