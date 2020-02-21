Rails.application.routes.draw do
  resources :books do
    collection do
      get 'genre_search'
    end
  end
  resources :libraries
  resources :genres
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
end
