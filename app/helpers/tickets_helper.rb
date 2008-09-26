module TicketsHelper
  def totals_helper(status)
    if @totals[status].to_i > 0
      return "<span class='total'>#{@totals[status]}</span>"
    end
  end
end
