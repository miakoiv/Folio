Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users

  root to: 'dashboard#index'
  resources :municipalities, only: :index
  resources :postcodes, only: :index

  resources :liaisons, only: :index
  resources :events, only: :index

  resources :people do
    resources :liaisons, shallow: true, except: :index do
      resources :documents
      resources :events, except: :index do
        get :search, on: :collection
      end
      resources :notes
    end
    resources :images, shallow: true
    resources :relationships, shallow: true, except: [:index, :show]
    get :parents, on: :collection
  end

  resources :users do
    resources :events, except: :index do
      get :search, on: :collection
    end
    resources :images, shallow: true
  end

  resources :memos

  post 'search', to: 'search#index', as: :search
  get 'reports', to: 'reports#index', as: :reports
end
