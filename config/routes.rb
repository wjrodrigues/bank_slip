Rails.application.routes.draw do
  get "/", to: redirect("/bankslips")

  resources :bankslips, only: %i[index new create destroy]
end
