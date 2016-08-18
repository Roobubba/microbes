Rails.application.routes.draw do
  
  root 'pages#home'
  
  get '/home', to: 'pages#home'

  get '/microbes_dl/:uniqueid(.:format)/:id(.:format)', to: 'microbes#export', as: 'microbe_dl'
  get '/getuserid/:uniqueid(.:format)', to: 'users#get_user_id'
  get '/microbes/:id(.:format)/buy', to: 'microbes#buy', as: 'buy_microbe'
  
  resources :microbes
  resources :morphologies
  
  resources :users, except: [:new]
  
  get '/register', to: 'users#new'

  get '/login', to: 'logins#new'
  post '/login', to: 'logins#create'
  get '/logout', to: 'logins#destroy'
  
end
