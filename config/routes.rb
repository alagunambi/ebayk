Rails.application.routes.draw do
  resources :accounts
  resources :ads
  match "/scrapping" => "visitors#scrapping", via: [ :post, :get ]
  match "/destroy_all" => "visitors#destroy_all", via: [ :post, :get ]
  post 'ads/today_csv' => "ads#today_csv"
  post '/export_with_date' => 'ads#export_with_date'
  root to: 'visitors#index'

  
end
