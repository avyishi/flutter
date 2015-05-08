Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :flits
  get 'about' => 'static_pages#about'

  
  root to: 'static_pages#home'
end
