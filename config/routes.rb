Rails.application.routes.draw do
  resources :files, only: [:index, :show, :create, :destroy]
end
