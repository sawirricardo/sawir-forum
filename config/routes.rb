Rails.application.routes.draw do
  root 'fronts#index'
  get 'feed', to: 'fronts#feed', as: :feed

  get 'login', to: 'sessions#new', as: :session
  post 'login', to: 'sessions#create'
  delete 'login', to: 'sessions#destroy'

  get 'setting', to: 'users#edit', as: :edit_user
  get 'register', to: 'users#new', as: :new_user
  post 'users', to: 'users#create', as: :users
  patch 'users', to: 'users#update'

  get 'profiles/:username', to: 'profiles#show', as: :profile, constraints: { username: /.*/ }
  post 'profiles/:username/follow', to: 'followers#create', as: :follower, constraints: { username: /.*/ }
  delete 'profiles/:username/follow', to: 'followers#destroy', constraints: { username: /.*/ }

  get 'articles', to: 'articles#index', as: :articles
  get 'articles/new', to: 'articles#new', as: :new_article
  post 'articles', to: 'articles#create'
  get 'articles/:slug/edit', to: 'articles#edit', as: :edit_article
  get 'articles/:slug', to: 'articles#show', as: :article
  patch 'articles/:slug', to: 'articles#update'
  delete 'articles/:slug', to: 'articles#destroy'

  post 'articles/:slug/comments', to: 'comments#create', as: :comments
  get 'articles/:slug/comment/:comment_id', to: 'comments#edit', as: :edit_comment
  patch 'articles/:slug/comment/:comment_id', to: 'comments#update', as: :comment
  delete 'articles/:slug/comments/:comment_id', to: 'comments#destroy'

  post 'articles/:slug/favorite', to: 'favoriters#create', as: :favoriters
  delete 'articles/:slug/favorite', to: 'favoriters#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
