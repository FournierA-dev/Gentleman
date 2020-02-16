Rails.application.routes.draw do

  root to: "teams#index"

  devise_for :players
  resources :players, only: [:show, :edit, :update, :index]
  resources :teams, only: [:index, :show]
  resources :matchs, only: [:index,:update] do
    resources :scores, only: [:new, :create, :edit, :update]
  end
  

  namespace :admin do
    resources :players, except: [:show]
    resources :pools, only: [:index, :create, :destroy]
    resources :teams, only: [:index, :create, :edit, :update, :destroy]
    resources :scores, only: [:index, :edit, :destroy, :update]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
