Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }

  mount ActionCable.server => '/cable'
  
  namespace :user do
    post '/send_email', to: 'send_email#create'
  end

  concern :voteable do
    member do
      put :vote_like, as: :like
      put :vote_dislike, as: :dislike
      delete :deselect
    end
  end

  get 'check_reward', to: 'rewards#check_reward', as: 'reward'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "questions#index"

  resources :questions, shallow: true, except: :new, concerns: :voteable do
    resources :answers, except: :show, concerns: :voteable do
      patch :star, on: :member
    end
  end

  resources :attachments, only: :destroy
  resources :links, only: :destroy
end
