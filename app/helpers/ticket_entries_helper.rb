module TicketEntriesHelper
  
  def billable(entry)
    if entry.billable == true
      return "Yes"
    else
      return "No"
    end
  end
  
  def note_to_html(entry)
    RedCloth.new(entry.note).to_html
  end

end
