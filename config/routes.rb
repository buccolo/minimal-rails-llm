Rails.application.routes.draw do
  resources :documents
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'chats#index'

  resources :chats do
    resources :messages, only: :create
  end
end
