Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'home#index'
  get 'index' => 'home/index'

  resources :insurances

  resource :dashboard, only: [:index]
  get 'dashboard(/:id)', controller: 'dashboard', to: 'dashboard#index', as: 'dashboard'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resource :users, only: [:edit] do
    collection do
      put 'update_password'
    end
  end

  get '/:id', to: 'users#show', as: :user
end
