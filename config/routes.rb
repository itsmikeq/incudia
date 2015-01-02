Incudia::Application.routes.draw do

  devise_for :users #, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resources :focals

  resources :areas

  resources :ext_services

  namespace :admin do
    resources :ext_services
  end

  resources :memberships

  resources :notifications

  resources :broadcast_messages

  resources :groups

  resources :namespaces

  resources :companies

  resources :interests

  root "pages#home"    
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  
      

  namespace :admin do
    root "base#index"
    resources :users
    
  end
  
end
