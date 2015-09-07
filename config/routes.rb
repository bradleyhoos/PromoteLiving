Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'home#index'
  get 'index' => 'home/index'

  resources :insurances
  devise_for :users, controllers: { sessions: 'users/sessions' }
end
