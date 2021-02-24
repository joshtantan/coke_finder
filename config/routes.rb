Rails.application.routes.draw do
  root "home#main"
  get "/updates/:id", to: "home#show"
end
