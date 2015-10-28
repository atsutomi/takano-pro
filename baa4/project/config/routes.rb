Anatock::Application.routes.draw do
  root to: "ranking#index"
  resources :stocks, only: [:index, :show] do
    collection { get "search1"}
    collection { get "search2"}
    collection { get "page"}
    collection {get "pagef"}
    collection {get "pagen"}
  end
  resources :ranking, only: [:index] do
    collection { get "ranking"}
  end
end