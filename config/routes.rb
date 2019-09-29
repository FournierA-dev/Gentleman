Rails.application.routes.draw do

  root to: "teams#index"

  devise_for :players
  resources :players, only: [:show, :edit, :update, :index]
  resources :teams, only: [:index]
  resources :matchs, only: [:edit,:update,:index] do
    resources :scores, only: [:edit,:update]
  end
  

  namespace :admin do
    resources :players, except: [:show]
    resources :pools, only: [:new, :create, :destroy]
    resources :teams
  end


  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
