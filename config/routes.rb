Rails.application.routes.draw do
  resources :bankslips, only: :index
end
