# == Route Map
#
#                   Prefix Verb   URI Pattern                            Controller#Action
#         new_user_session GET    /users/sign_in(.:format)               devise/sessions#new
#             user_session POST   /users/sign_in(.:format)               devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)              devise/sessions#destroy
#            user_password POST   /users/password(.:format)              devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)          devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)         devise/passwords#edit
#                          PATCH  /users/password(.:format)              devise/passwords#update
#                          PUT    /users/password(.:format)              devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                devise/registrations#cancel
#        user_registration POST   /users(.:format)                       devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)               devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)                  devise/registrations#edit
#                          PATCH  /users(.:format)                       devise/registrations#update
#                          PUT    /users(.:format)                       devise/registrations#update
#                          DELETE /users(.:format)                       devise/registrations#destroy
#        user_confirmation POST   /users/confirmation(.:format)          devise/confirmations#create
#    new_user_confirmation GET    /users/confirmation/new(.:format)      devise/confirmations#new
#                          GET    /users/confirmation(.:format)          devise/confirmations#show
#              focalpoints GET    /focalpoints(.:format)                 focalpoints#index
#                          POST   /focalpoints(.:format)                 focalpoints#create
#           new_focalpoint GET    /focalpoints/new(.:format)             focalpoints#new
#          edit_focalpoint GET    /focalpoints/:id/edit(.:format)        focalpoints#edit
#               focalpoint GET    /focalpoints/:id(.:format)             focalpoints#show
#                          PATCH  /focalpoints/:id(.:format)             focalpoints#update
#                          PUT    /focalpoints/:id(.:format)             focalpoints#update
#                          DELETE /focalpoints/:id(.:format)             focalpoints#destroy
#                    areas GET    /areas(.:format)                       areas#index
#                          POST   /areas(.:format)                       areas#create
#                 new_area GET    /areas/new(.:format)                   areas#new
#                edit_area GET    /areas/:id/edit(.:format)              areas#edit
#                     area GET    /areas/:id(.:format)                   areas#show
#                          PATCH  /areas/:id(.:format)                   areas#update
#                          PUT    /areas/:id(.:format)                   areas#update
#                          DELETE /areas/:id(.:format)                   areas#destroy
#             ext_services GET    /ext_services(.:format)                ext_services#index
#                          POST   /ext_services(.:format)                ext_services#create
#          new_ext_service GET    /ext_services/new(.:format)            ext_services#new
#         edit_ext_service GET    /ext_services/:id/edit(.:format)       ext_services#edit
#              ext_service GET    /ext_services/:id(.:format)            ext_services#show
#                          PATCH  /ext_services/:id(.:format)            ext_services#update
#                          PUT    /ext_services/:id(.:format)            ext_services#update
#                          DELETE /ext_services/:id(.:format)            ext_services#destroy
#       admin_ext_services GET    /admin/ext_services(.:format)          admin/ext_services#index
#                          POST   /admin/ext_services(.:format)          admin/ext_services#create
#    new_admin_ext_service GET    /admin/ext_services/new(.:format)      admin/ext_services#new
#   edit_admin_ext_service GET    /admin/ext_services/:id/edit(.:format) admin/ext_services#edit
#        admin_ext_service GET    /admin/ext_services/:id(.:format)      admin/ext_services#show
#                          PATCH  /admin/ext_services/:id(.:format)      admin/ext_services#update
#                          PUT    /admin/ext_services/:id(.:format)      admin/ext_services#update
#                          DELETE /admin/ext_services/:id(.:format)      admin/ext_services#destroy
#              memberships GET    /memberships(.:format)                 memberships#index
#                          POST   /memberships(.:format)                 memberships#create
#           new_membership GET    /memberships/new(.:format)             memberships#new
#          edit_membership GET    /memberships/:id/edit(.:format)        memberships#edit
#               membership GET    /memberships/:id(.:format)             memberships#show
#                          PATCH  /memberships/:id(.:format)             memberships#update
#                          PUT    /memberships/:id(.:format)             memberships#update
#                          DELETE /memberships/:id(.:format)             memberships#destroy
#            notifications GET    /notifications(.:format)               notifications#index
#                          POST   /notifications(.:format)               notifications#create
#         new_notification GET    /notifications/new(.:format)           notifications#new
#        edit_notification GET    /notifications/:id/edit(.:format)      notifications#edit
#             notification GET    /notifications/:id(.:format)           notifications#show
#                          PATCH  /notifications/:id(.:format)           notifications#update
#                          PUT    /notifications/:id(.:format)           notifications#update
#                          DELETE /notifications/:id(.:format)           notifications#destroy
#       broadcast_messages GET    /broadcast_messages(.:format)          broadcast_messages#index
#                          POST   /broadcast_messages(.:format)          broadcast_messages#create
#    new_broadcast_message GET    /broadcast_messages/new(.:format)      broadcast_messages#new
#   edit_broadcast_message GET    /broadcast_messages/:id/edit(.:format) broadcast_messages#edit
#        broadcast_message GET    /broadcast_messages/:id(.:format)      broadcast_messages#show
#                          PATCH  /broadcast_messages/:id(.:format)      broadcast_messages#update
#                          PUT    /broadcast_messages/:id(.:format)      broadcast_messages#update
#                          DELETE /broadcast_messages/:id(.:format)      broadcast_messages#destroy
#                   groups GET    /groups(.:format)                      groups#index
#                          POST   /groups(.:format)                      groups#create
#                new_group GET    /groups/new(.:format)                  groups#new
#               edit_group GET    /groups/:id/edit(.:format)             groups#edit
#                    group GET    /groups/:id(.:format)                  groups#show
#                          PATCH  /groups/:id(.:format)                  groups#update
#                          PUT    /groups/:id(.:format)                  groups#update
#                          DELETE /groups/:id(.:format)                  groups#destroy
#               namespaces GET    /namespaces(.:format)                  namespaces#index
#                          POST   /namespaces(.:format)                  namespaces#create
#            new_namespace GET    /namespaces/new(.:format)              namespaces#new
#           edit_namespace GET    /namespaces/:id/edit(.:format)         namespaces#edit
#                namespace GET    /namespaces/:id(.:format)              namespaces#show
#                          PATCH  /namespaces/:id(.:format)              namespaces#update
#                          PUT    /namespaces/:id(.:format)              namespaces#update
#                          DELETE /namespaces/:id(.:format)              namespaces#destroy
#                companies GET    /companies(.:format)                   companies#index
#                          POST   /companies(.:format)                   companies#create
#              new_company GET    /companies/new(.:format)               companies#new
#             edit_company GET    /companies/:id/edit(.:format)          companies#edit
#                  company GET    /companies/:id(.:format)               companies#show
#                          PATCH  /companies/:id(.:format)               companies#update
#                          PUT    /companies/:id(.:format)               companies#update
#                          DELETE /companies/:id(.:format)               companies#destroy
#                interests GET    /interests(.:format)                   interests#index
#                          POST   /interests(.:format)                   interests#create
#             new_interest GET    /interests/new(.:format)               interests#new
#            edit_interest GET    /interests/:id/edit(.:format)          interests#edit
#                 interest GET    /interests/:id(.:format)               interests#show
#                          PATCH  /interests/:id(.:format)               interests#update
#                          PUT    /interests/:id(.:format)               interests#update
#                          DELETE /interests/:id(.:format)               interests#destroy
#                     root GET    /                                      pages#home
#                     home GET    /home(.:format)                        pages#home
#                   inside GET    /inside(.:format)                      pages#inside
#               admin_root GET    /admin(.:format)                       admin/base#index
#              admin_users GET    /admin/users(.:format)                 admin/users#index
#                          POST   /admin/users(.:format)                 admin/users#create
#           new_admin_user GET    /admin/users/new(.:format)             admin/users#new
#          edit_admin_user GET    /admin/users/:id/edit(.:format)        admin/users#edit
#               admin_user GET    /admin/users/:id(.:format)             admin/users#show
#                          PATCH  /admin/users/:id(.:format)             admin/users#update
#                          PUT    /admin/users/:id(.:format)             admin/users#update
#                          DELETE /admin/users/:id(.:format)             admin/users#destroy
#

Incudia::Application.routes.draw do

  resources :social_nets

  resources :broadcast_messages

  resources :social_nets_users

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resource :profile, only: [:show, :update] do
    member do
      get :history

      put :reset_private_token
      put :update_username
    end
    scope module: :profiles do
      resource :account, only: [:show, :update]

      resource :password, only: [:new, :create, :edit, :update] do
        member do
          put :reset
        end
      end
      resources :emails, only: [:index, :create, :destroy]
    end

  end
  match "/u/:username" => "users#show", as: :user, constraints: { username: /.*/ }, via: :get

  resources :focalpoints

  resources :areas

  resources :ext_services

  namespace :admin do
    resources :ext_services
  end

  resources :memberships

  resources :notifications

  resources :groups

  resources :namespaces

  resources :companies

  resources :interests

  root "pages#home"    
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
      

  namespace :admin do
    root "base#index"
    resources :users
    
  end
  
end
