class Iphone::TicketsController < ApplicationController
  before_filter :login_required
  before_filter :load_totals, :except => [:create, :update]
  layout nil
  
  def show
    @ticket = Ticket.find(params[:id])
  end
  
  def index
    if params[:client_id]
      @tickets = Ticket.find(:all, :conditions => {:client_id => params[:client_id]})
      @tickets = @tickets.sort_by{|ticket| [ticket.status, ticket.id]}
    elsif params[:device_id]
      @tickets = Device.find(params[:device_id]).tickets
    else
      if params[:status]
        @tickets = Ticket.limit(params[:status], current_user, params[:scope])
        @tickets = @tickets.sort_by{|ticket| [ticket.status, ticket.id]}
      else
        @tickets = []
      end
    end
  end
  
  protected
  
    def load_totals
      @totals = Ticket.totals(current_user)
    end
  
end