class TicketEntriesController < ApplicationController
  before_filter :login_required
  layout nil
  
  def index
    @ticket_entries = TicketEntry.find_all_by_ticket_id(params[:ticket_id])
  end

  def new
    @ticket_entry = TicketEntry.new(:billable => true)
  end

  def create
    @ticket_entry = TicketEntry.new(params[:ticket_entry])
    @ticket = Ticket.find(@ticket_entry.ticket_id)
    
    respond_to do |format|
      if @ticket_entry.save
        flash[:notice] = 'Ticket entry was successfully created.'
        format.html { redirect_to(@ticket) }
        format.xml  { render :xml => @ticket_entry, :status => :created, :location => @ticket_entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ticket_entry.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @ticket_entry = TicketEntry.find(params[:id])

    respond_to do |format|
      if @ticket_entry.update_attributes(params[:ticket_entry])
        flash[:notice] = 'Ticket entry was successfully updated.'
        format.html { redirect_to(@ticket_entry) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticket_entry.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
