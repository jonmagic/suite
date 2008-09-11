ActionController::Routing::Routes.draw do |map|
  map.resources :tickets

  map.resources :programs

  map.resources :components

  map.resources :devices


  map.resources :clients
  map.resources :phones
  map.resources :emails
  map.resources :addresses
  
  map.resource :sessions
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
  map.connect '/', :controller => 'clients', :action => 'index'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
