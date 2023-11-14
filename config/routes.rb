Rails.application.routes.draw do
  devise_for :users

  get 'check_reward', to: 'rewards#check_reward', as: 'reward'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "questions#index"

  resources :questions, shallow: true, except: :new do
    resources :answers, except: :show do
      patch :star, on: :member
    end
  end

  resources :attachments, only: :destroy
  resources :links, only: :destroy
end
