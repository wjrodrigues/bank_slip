Rails.application.routes.draw do
  resources :bankslips, only: %i[index new create destroy]
end
