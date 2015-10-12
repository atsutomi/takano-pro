Anatock::Application.routes.draw do
  root to: "ranking#index"
  resources :stocks, only: [:index, :show] do
    collection {get "search"}
    collection {get "page"}
    collection {get "pagef"}
    collection {get "pagen"}
  end
  
  resources :ranking, only: [:index] do
  end
  
end
