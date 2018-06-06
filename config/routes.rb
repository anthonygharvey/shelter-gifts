Rails.application.routes.draw do
  resources :users do
    resources :shelters, shallow: true do
      resources :lists, shallow: true
    end
  end
end
