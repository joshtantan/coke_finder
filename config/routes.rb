Rails.application.routes.draw do
  root "home#main"
  resources :updates, only: [:index, :show], controller: "home"
end
