Rails.application.routes.draw do
  resources :ads
  match "/scrapping" => "visitors#scrapping", via: [ :post, :get ]
  match "/destroy_all" => "visitors#destroy_all", via: [ :post, :get ]
  root to: 'visitors#index'
end
