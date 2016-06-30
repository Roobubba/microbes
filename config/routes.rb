Rails.application.routes.draw do
  
  root 'pages#home'
  
  get '/home', to: 'pages#home'
  
  get '/users_dl/:id(.:format)', to: 'users#export', as: 'user_dl'
  get '/microbes_dl/:id(.:format)', to: 'microbes#export', as: 'microbe_dl'
  get '/getuserid/:uniqueid(.:format)', to: 'users#get_user_id'
  
  resources :microbes, except: [:new, :create, :destroy, :edit, :update]
  
  resources :users, except: [:new, :destroy]
  
  get '/register', to: 'users#new'
  
  get '/login', to: 'logins#new'
  post '/login', to: 'logins#create'
  get '/logout', to: 'logins#destroy'
  
  
  
end
