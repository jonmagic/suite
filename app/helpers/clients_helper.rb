module ClientsHelper
  
  def person_or_company(client)
    if client.company == true
      return "company"
    else
      return "person"
    end
  end

  def add_phone_link(name) 
    link_to_function image_tag("/images/icons/add.png") do |page| 
      page.insert_html :bottom, :phones, :partial => 'phone', :object => Phone.new
    end 
  end
  
  def add_email_link(name) 
    link_to_function image_tag("/images/icons/add.png") do |page| 
      page.insert_html :bottom, :emails, :partial => 'email', :object => Email.new
    end 
  end
  
  def add_address_link(name) 
    link_to_function image_tag("/images/icons/add.png") do |page| 
      page.insert_html :bottom, :addresses, :partial => 'address', :object => Address.new
    end 
  end

  def my_account(client)
    if client.id == current_user.client_id
      return true
    else
      return false
    end
  end
  
  def not_a_user(client)
    if User.find_by_client_id(client.id)
      return false
    else
      return true
    end
  end
  
  def total_clients
    @clients = Client.find(:all)
    return @clients.length
  end
  
  def total_open_tickets
    @open_tickets = Ticket.find(:all, :conditions => {:archived_on => nil})
    @open_tickets.length
  end
  
  def total_archived_tickets
    future = Date.today + 100.years
    past = Date.today - 100.years
    @archived_tickets = Ticket.find(:all, :conditions => {:archived_on => past..future})
    @archived_tickets.length
  end
  
  def hours_billed_this_week
    return ""
  end

end