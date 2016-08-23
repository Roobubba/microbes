Rails.application.routes.draw do
  
  root 'pages#home'
  
  get '/home', to: 'pages#home'

  get '/microbes_dl/:uniqueid(.:format)/:id(.:format)', to: 'microbes#export', as: 'microbe_dl'
  
  get '/getuserid/:uniqueid(.:format)', to: 'users#get_user_id'

  get '/microbes/:id(.:format)/buy', to: 'microbes#buy', as: 'buy_microbe'
  
  resources :microbes
  resources :morphologies
  
  resources :users, except: [:new, :create]

  post '/authHBSMHS', to: 'sessions#create'

  get '/login', to: 'sessions#new', as: 'login'
  get '/oauth2gcallback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  

end
