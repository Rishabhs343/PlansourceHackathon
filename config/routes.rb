Rails.application.routes.draw do
  devise_for :users
  resources :challenges do
    member do
      put :like, to:'challenges#upvote'
      put :follow, to:'challenges#follow'
    end
  end
  get '/search' => 'challenges#search', :as => 'search_page'
  root 'challenges#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
