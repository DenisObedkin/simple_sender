require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'sending#index'

  namespace :admin do
    mount Sidekiq::Web => '/sidekiq' # Sidekiq UI
  end

  post :send_mail, to: 'sending#send_mail'
end
