Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'home#index'
  get 'index' => 'home/index'

  resources :insurances, :health_savings_accounts, :rewards_cards
  resource :dashboard, only: [:index]

  resource :users, only: [:edit] do
    collection do
      put 'update_password'
    end
  end

  get '/:id', to: 'users#show', as: :user
  get 'dashboard(/:id)', controller: 'dashboard', to: 'dashboard#index', as: 'dashboard'
  get '/rewards_card_chooser', controller: 'rewards_cards', to: 'rewards_cards#rewards_card_chooser', as: 'rewards_card_chooser'

  # make sure this is the very last route!!
  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404', via: [:get, :post]
  end
end
