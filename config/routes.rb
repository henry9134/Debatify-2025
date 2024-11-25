Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :dashboards, only: [:show]

  resources :topics, only: [:index, :new, :create, :show] do
    resources :comments, only: [:new, :create]
    member do
      post 'toggle_favourite', to: "topics#toggle_favorite"
    end
  end

  resources :comments, only: [] do
    member do
      patch 'upvote', to: "comments#upvote"
    end
  end
end
