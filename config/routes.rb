Rails.application.routes.draw do
  devise_for :users

  concern :voteable do
    member do
      put :vote_like, as: :like
      put :vote_dislike, as: :dislike
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
