Rails.application.routes.draw do
  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  
  resources :users do
    resources :shelters, shallow: true do
      resources :lists, shallow: true
    end
  end

  # root 'shelters#show'

end
