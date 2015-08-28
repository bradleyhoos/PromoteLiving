Rails.application.routes.draw do
	get 'index' => 'home/index'
	resources :insurances
	devise_for :users, controllers: { sessions: "users/sessions" }
	root to: 'home#index'
  
  end
