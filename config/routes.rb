Rails.application.routes.draw do
  resources :ads
  root to: 'visitors#index'
end
