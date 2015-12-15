Anatock::Application.routes.draw do
  root to: "ranking#index"
  resources :stocks, only: [:index, :show] do
    collection { get "search1"}
    collection { get "search2"}

  end
  resources :ranking, only: [:index] do
    collection { get "anatock"}
  end
end