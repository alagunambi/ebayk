Rails.application.routes.draw do
  resources :ads
  match "/scrapping" => "visitors#scrapping", via: [ :post, :get ]
  root to: 'visitors#index'
end
