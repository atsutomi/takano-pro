Anatock::Application.routes.draw do
  root to: "ranking#index"
  resources :stocks, only: [:index, :show] do
    collection { get "search" }
  end
  resources :ranking, only: [:index]
end