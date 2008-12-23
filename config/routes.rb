ActionController::Routing::Routes.draw do |map|

  # Restful Authentication
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.forgot_password '/forgot_password', :controller => 'passwords', :action => 'new'
  map.change_password '/change_password/:reset_code', :controller => 'passwords', :action => 'reset'
  map.create_password '/create_password/:reset_code', :controller => 'passwords', :action => 'create_password'
  map.resources :users
  map.resources :passwords
  map.resource :session

  # Main Resources
  map.search_clients '/clients/search', :controller => 'clients', :action => 'search'
  map.resources :clients do |client|
    client.resources :tickets
    client.resources :devices
    client.resources :users
  end
  map.search_tickets '/tickets/search', :controller => 'tickets', :action => 'search'
  map.resources :tickets do |ticket|
    ticket.resources :ticket_entries
    ticket.resources :devices
    ticket.resources :checklists
  end
  map.resources :devices do |device|
    device.resources :checklists
    device.resources :tickets
    device.resources :sentries
  end

  # Secondary Resources
  map.resources :ticket_entries
  map.resources :device_types
  map.resources :sentries do |sentry|
    sentry.resources :events
  end
  map.resources :settings
  map.resources :things
  map.resources :checklists
  map.resources :checklist_templates
  map.resources :goggles
  map.resources :schedules
  map.resources :radchecks
  map.resources :sentries
  
  # Custom Routes
  map.device_details '/tickets/:ticket_id/devices/:id/details', :controller => 'devices', :action => 'details'
  map.add_to_ticket '/tickets/:ticket_id/devices/:id/add_to_ticket', :controller => 'devices', :action => 'add_to_ticket'
  map.remove_device_from_ticket '/tickets/:ticket_id/devices/:id/remove_from_ticket', :controller => 'devices', :action => 'remove_from_ticket'
  map.add_association '/checklist_templates/:checklist_template_id/device_types/:id/add_association', :controller => 'checklist_templates', :action => "add_assocation"
  map.remove_association '/checklist_templates/:checklist_template_id/device_types/:id/remove_association', :controller => 'checklist_templates', :action => "remove_assocation"
  map.remove_checklist_from_ticket '/tickets/:ticket_id/checklists/:id/remove_from_ticket', :controller => 'checklists', :action => 'remove_from_ticket'

  # iPhone routes
  map.namespace :iphone do |iphone|
    iphone.resources :clients do |client|
      client.resources :tickets
      client.resources :devices
    end
    iphone.resources :tickets do |ticket|
      ticket.resources :devices
    end
    iphone.resources :devices do |device|
      device.resources :tickets
    end
    iphone.root :controller => 'clients', :action => 'home'
  end
  
  # Home Page
  map.root :controller => 'tickets', :action => 'index'
  
  # Last but not least
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
