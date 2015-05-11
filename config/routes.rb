Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  resources :flits
  get 'about' => 'static_pages#about'

  
  root to: 'static_pages#home'
end
