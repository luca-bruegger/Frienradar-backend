# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :user,
             controllers: {
               sessions: 'user/sessions',
               registrations: 'user/registrations',
               confirmations: 'user/confirmations',
               passwords: 'user/passwords'
             }

  match '/current_user', to: 'current_user#show', via: :get
  match '/current_user', to: 'current_user#update', via: :put
  match '/requested_users', to: 'requested_users#show', via: :get
  match '/friends', to: 'friends#show', via: :get
  match '/current_user/edited', to: 'current_user#update_with_profile_picture', via: :put

  scope '/invitations' do
    match '/accept', to: 'invitations#accept', via: :put
  end

  resources :geolocations, only: [:update]
  resources :nearby_users
  resources :invitations, only: [:create, :index, :show, :destroy]
  resources :profiles, only: [:show]
  resources :social_accounts

  root to: proc { [404, {}, ['Not found. But everything is working fine. Have a nice day!']] }
end
