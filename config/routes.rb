Rails.application.routes.draw do
  resources :users do
    resources :shelters, shallow: true
  end
end
