class Iphone::TicketsController < ApplicationController
  before_filter :login_required
  before_filter :load_totals, :except => [:create, :update]
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
  
  protected
  
    def load_totals
      @totals = Ticket.totals(current_user)
    end
  
end