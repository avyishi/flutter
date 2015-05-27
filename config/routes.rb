Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :flits
  resources :relationships,       only: [:create, :destroy]

  get 'about' => 'static_pages#about'

  
  root to: 'static_pages#home'
end
