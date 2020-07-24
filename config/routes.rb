Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/index'
  namespace :api, format: 'json' do
    resources :tasks, only: [:index, :create, :update]
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
