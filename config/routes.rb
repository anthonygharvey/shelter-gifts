Rails.application.routes.draw do
  resources :users do
    resources :shelters
  end
end
