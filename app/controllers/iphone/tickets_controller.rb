class Iphone::TicketsController < ApplicationController
  before_filter :login_required
  layout nil
  
  def show
    @ticket = Ticket.find(params[:id])
  end
  
  def index
    if params[:status]
      @tickets = Ticket.limit(params[:status], params[:scope], current_user, params[:device])
      @tickets = @tickets.sort_by{|ticket| [ticket.status, ticket.id]}
    else
      @tickets = []
    end
  end
  
end