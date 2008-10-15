module TicketEntriesHelper
  
  def billable(entry)
    if entry.billable == true
      return "Yes"
    else
      return "No"
    end
  end

end
