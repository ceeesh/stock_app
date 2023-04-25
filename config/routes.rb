Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
  resources :posts
  get '/signin' => 'auth#signin'
  get '/signup' => 'auth#signup'
  post '/signin' => 'auth#new_session'
  post '/signup' => 'auth#new_account'
  delete '/logout' => 'auth#logout'

  get '/home' => 'user#index'

  get '/user/:id' => 'user#show', as: 'user'
  get '/user/:id/edit' => 'user#edit', as: 'edit_user'
  patch '/user/:id' => 'user#update'
  delete '/user/:id' => 'user#delete'

  get '/transactions/index' => 'transactions#index'

  get '/transactions/buy_stock/:symbol' => 'transactions#buy_stock', as: 'transactions_buy'
  post '/transactions/buy_stock/:symbol' => 'transactions#buy'
  
  get '/transactions/sell_stock/:symbol' => 'transactions#sell_stock', as: 'transactions_sell'
  post '/transactions/sell_stock/:symbol' => 'transactions#sell'

  get '/portfolio/index' => 'portfolio#index'

  # post '/admin/dashboard' => 'admin/dashboard#create', as: 'create_admin_dashboard'
  get 'admin/dashboard/pendingusers' => 'admin/dashboard#pending_users', as: 'pending_users'
  namespace :admin do 
    resources :dashboard
  end

end
