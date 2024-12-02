Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  get 'dashboard', to: 'dashboards#dashboard'

  resources :topics, only: [:index, :new, :create, :show] do
    resources :comments, only: [:new, :create]

    # Toggle favorite action for topics
    member do
      post 'toggle_favourite', to: "topics#toggle_favorite" # Existing
    end

    # Favorite actions
    resource :favorite, only: [:create, :destroy] # Added for favoriting/unfavoriting
  end

  resources :comments, only: [] do
    member do
      patch 'upvote', to: "comments#upvote"
    end
  end

  resources :users, only: [:show, :edit, :update]

  resources :topics do
    member do
      post :update_thermometer
    end
  end
end
