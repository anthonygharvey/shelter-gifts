Rails.application.routes.draw do
  get '/register' => 'users#new'
  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/auth/:provider/callback' => 'sessions#create'
  
  resources :users do
    resources :shelters, shallow: true do
			resources :lists, shallow: true do
				resources :items
      end
    end
  end
  resources :items, only: [:index]

	root 'static#index'
  get '/:page' => 'static#show'

end
