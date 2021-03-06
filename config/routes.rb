Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, only: [:update, :show, :index]

  resources :topics do
    resources :posts, except: [:index], controller: 'topics/posts'
  end

  resources :posts, only: [:index] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]

    resource :vote, as: :up_vote, path: '/up-vote', action: :up_vote, only: :create
    resource :vote, as: :down_vote, path: '/down-vote', action: :down_vote, only: :create

    # post '/up-vote' => 'votes#up_vote', as: :up_vote
    # post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'

end
