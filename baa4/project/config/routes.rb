Project::Application.routes.draw do
  root to: "stocks#show"
  
  resources :stocks, only: [:index, :show]
end