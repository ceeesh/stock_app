Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'home#index'
  
  get '/signin' => 'auth#signin'
  get '/signup' => 'auth#signup'
  post '/signin' => 'auth#new_session'
  post '/signup' => 'auth#new_account'
  delete '/logout' => 'auth#logout'

  get '/home' => 'user#index'
end
