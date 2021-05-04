# frozen_string_literal: true

Rails.application.routes.draw do
  match '/404', to: 'errors#page_not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  devise_for :users
  resources :challenges do
    member do
      put :like, to: 'challenges#upvote'
      put :follow, to: 'challenges#follow'
    end
  end
  resources :users do
    member do
      get 'api_token'
    end
  end
  namespace :api do
    resources :challenges
  end
  get '/search' => 'challenges#search', :as => 'search_page'
  root 'challenges#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
