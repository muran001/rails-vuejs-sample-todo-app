Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/index'
  namespace :api, format: 'json' do
    resources :tasks, only: [:index, :create, :update]
  end

  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'api/auth/registrations'
  }
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
