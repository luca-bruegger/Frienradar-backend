Rails.application.routes.draw do
  namespace :api do
    devise_for :user, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }

    get '/current_user', to: 'current_user#index', as: 'current_user'

    root to: 'github.com'
  end

  root to: proc { [404, {}, ["Not found."]] }
end
