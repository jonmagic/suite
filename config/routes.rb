ActionController::Routing::Routes.draw do |map| 
  # Restful Authentication Rewrites
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.forgot_password '/forgot_password', :controller => 'passwords', :action => 'new'
  map.change_password '/change_password/:reset_code', :controller => 'passwords', :action => 'reset'
  
  # Restful Authentication Resources
  map.resources :users
  map.resources :passwords
  map.resource :session

  map.client_list '/clients/list', :controller => 'clients', :action => 'list'
  
  map.resources :clients do |client|
    client.resources :tickets
    client.resources :devices
  end

  map.resources :ticket_entries
  map.resources :tickets do |ticket|
    ticket.resources :ticket_entries
  end
  
  map.resources :devices do |device|
    device.resources :inventory_items
  end
  
  # Home Page
  map.root :controller => 'tickets', :action => 'index'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
