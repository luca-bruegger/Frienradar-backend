# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :user,
             controllers: {
               sessions: 'user/sessions',
               registrations: 'user/registrations',
               confirmations: 'user/confirmations'
             }

  resources :current_user, only: [:index, :update]
  resources :geolocations, only: [:update]

  root to: proc { [404, {}, ['Not found.']] }
end
