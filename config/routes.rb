Rails.application.routes.draw do
  
  root 'pages#home'
  
  get '/home', to: 'pages#home'

  get '/microbes_dl/Android/:id(.:format)', to: 'microbes#exportandroid', as: 'microbe_dl_android'
  get '/microbes_dl/Windows/:id(.:format)', to: 'microbes#exportwindows', as: 'microbe_dl_windows'
  
  #get '/getuserid/:uniqueid(.:format)', to: 'users#get_user_id'

  get '/microbes/:id(.:format)/buy', to: 'microbes#buy', as: 'buy_microbe'
  
  resources :microbes
  resources :morphologies
  
  resources :users, except: [:new, :create]

  post '/authHBSMHS', to: 'sessions#game'

  #post '/authHBSMHS', to: 'sessions#testing'
  #get '/authHBSMHS', to: 'sessions#testing'
  get '/microbes_dl/testingWindows/:id(.:format)', to: 'microbes#exporttestingwindows', as: 'microbe_dl_testingwindows'
  
  get '/login', to: 'sessions#new', as: 'login'
  get '/oauth2gcallback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

end
