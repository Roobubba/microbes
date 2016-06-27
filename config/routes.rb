Rails.application.routes.draw do
  
  root 'pages#home'
  
  get '/home', to: 'pages#home'
  
  get '/users_dl/:id(.:format)', to: 'users#export_to_txt', as: 'user_dl'
  get '/microbes_dl/:id(.:format)', to: 'microbes#export_to_xml', as: 'microbe_dl'
  get '/getuserid/:uniqueid(.:format)', to: 'users#get_user_id'
  
  resources :microbes, except: [:new, :create, :destroy, :edit, :update]
  
  resources :users, except: [:new, :create, :destroy, :edit, :update]
  
end
