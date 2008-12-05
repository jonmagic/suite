module TicketEntriesHelper
  
  def billable(entry)
    if entry.billable == true
      return "Yes"
    else
      return "No"
    end
  end
  
  def is_this_private(entry)
    if entry.private == true
      return "Yes"
    else
      return "No"
    end
  end

end
