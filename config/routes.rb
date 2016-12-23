Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users

  post '/users/:user_id/privileges', to: 'privileges#create', as: :add_privilege
  delete '/users/:user_id/privileges/:name/:resource_gid',
    to: 'privileges#destroy', as: :remove_privilege

  root to: 'dashboard#index'
  get '/unit/(:unit_id)', to: 'dashboard#index', as: :unit_root

  resources :municipalities, only: :index
  resources :postcodes, only: :index

  resources :customers, only: :index
  resources :events, only: :index

  resources :people do
    resources :customers, shallow: true, except: :index do
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
    resources :events, shallow: true, only: [:new, :create] do
      get :search, on: :collection
    end
    resources :images, shallow: true
  end

  resources :memos do
    get :sent, on: :collection
  end

  post 'search', to: 'search#index', as: :search
  get 'reports', to: 'reports#index', as: :reports
end
