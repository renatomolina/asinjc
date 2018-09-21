Rails.application.routes.draw do
  resources :products
  root 'products#new'
end
