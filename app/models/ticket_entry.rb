class TicketEntry < ActiveRecord::Base
  belongs_to :ticket
  
  def creator
    creator = User.find(self.creator_id)
  end
  
end
