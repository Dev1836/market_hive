Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  devise_scope :user do  
     get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "up" => "rails/health#show", as: :rails_health_check
  get 'gainers', to: 'home#gainers'
  get 'losers', to: 'home#losers'
  get 'stock', to: 'home#stock'
end
