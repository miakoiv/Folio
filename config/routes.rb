Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users

  root to: 'dashboard#index'

  resources :municipalities, only: :index
  resources :postcodes, only: :index

  resources :events, only: :index

  resources :people do
    resources :images, shallow: true
    resources :liaisons, shallow: true, except: :index do
      resources :events, shallow: true, except: :index do
        get :search, on: :collection
      end
    end
  end
  resources :users do
    resources :images, shallow: true
  end
end
