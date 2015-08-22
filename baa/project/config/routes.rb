Project::Application.routes.draw do
  root to: "stocks#index"
  
  resources :stocks, only: [:index, :show]
end