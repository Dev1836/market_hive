Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  devise_scope :user do  
     get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :v1 do
      resources :stocks, only: [:create,:update] do
        resources :favorites, only: [:create, :destroy]
      end
    end
  end
  
  get "up" => "rails/health#show", as: :rails_health_check
end
