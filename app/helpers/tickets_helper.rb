module TicketsHelper
  def totals_helper(status)
    if @totals[status].to_i > 0
      return "<span>#{@totals[status]}</span>"
    end
  end
  
  def client_array
    @clients = Client.find(:all)
    array = []
    @clients.each do |client|
      array << '"'+client.fullname+'", '
    end
    return "["+array.to_s.chop.chop+"]"
  end
  
  def checklist_status(checklist)
    checklist.complete? ? image_tag('/images/icons/accept.png', :alt => "True") : ""
  end
end
