module ClientsHelper

  def add_phone_link(name) 
    link_to_function image_tag("/images/add.png") do |page| 
      page.insert_html :bottom, :phones, :partial => 'phone', :object => Phone.new 
    end 
  end
  
  def add_email_link(name) 
    link_to_function image_tag("/images/add.png") do |page| 
      page.insert_html :bottom, 'emails', :partial => 'email', :object => Email.new 
    end 
  end
  
  def add_address_link(name) 
    link_to_function image_tag("/images/add.png") do |page| 
      page.insert_html :bottom, 'addresses', :partial => 'address', :object => Address.new 
    end 
  end


end
