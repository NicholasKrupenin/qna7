require 'sidekiq/web'

Rails.application.routes.draw do

  authenticate :user, lambda {|u| u.admin?} do
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper

  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }

  mount ActionCable.server => '/cable'
  
  namespace :user do
    post '/send_email', to: 'send_email#create'
  end

  namespace :api do
    namespace :v1 do
      resource :profiles, only: [] do
        get :me, on: :collection
        get :index, on: :collection
      end

      resources :questions, except: [:new, :edit] do
        resources :answers, except: [:new, :edit], shallow: true
      end
    end
  end

  concern :voteable do
    member do
      put :vote_like, as: :like
      put :vote_dislike, as: :dislike
      delete :deselect
    end
  end

  concern :commentable do
    member do
      post :comment
    end
  end

  get 'check_reward', to: 'rewards#check_reward', as: 'reward'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "questions#index"

  resources :questions, shallow: true, except: :new, concerns: %i[voteable commentable] do
    resources :answers, except: :show, concerns: %i[voteable commentable] do
      patch :star, on: :member
    end
  end

  resources :attachments, only: :destroy
  resources :links, only: :destroy
end
