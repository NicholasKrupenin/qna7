Rails.application.routes.draw do
  devise_for :users
  
  mount ActionCable.server => '/cable'

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
