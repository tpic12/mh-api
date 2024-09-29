Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :world do
    resources :monsters, only: [:index, :show]
  end

  namespace :rise do
    resources :monsters, only: [:index, :show]
  end
end
