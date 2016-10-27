Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users

  root to: 'people#index'

  resources :municipalities, only: :index
  resources :postcodes, only: :index

  resources :people do
    resources :images, shallow: true
    resources :liaisons, shallow: true, except: :index
  end
  resources :users do
    resources :images, shallow: true
  end
end
