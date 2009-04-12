class TicketsController < ApplicationController
  before_filter :login_required
  before_filter :load_totals, :except => [:create, :update]
  
  def index
    @tickets = Ticket.limit(params[:status], current_user, params[:scope])
    @tickets = @tickets.sort_by{|ticket| [ticket.status, ticket.id]}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tickets }
      format.json  { render :json => @tickets }
    end
  end
  
  def search
    @tickets = Ticket.search(params[:q], :include => [:ticket_entries, :client])
  end

  def show
    @ticket = Ticket.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ticket }
      format.json  { render :json => @ticket }
    end
  end
  
  def new
    @ticket = Ticket.new
  end
  
  def create
    @ticket = Ticket.new(params[:ticket])
    
    respond_to do |format|
      if @ticket.save
        if params[:device_id] != nil
          @device = Device.find(params[:device_id])
          @ticket.devices << @device
          TicketEntry.create(:entry_type => "Add Device", :note => "Device (Service Tag: #{@device.service_tag}) was added to this ticket.", :billable => false, :private => true, :detail => 6, :ticket => @ticket, :creator_id => current_user.id)
        end
        flash[:notice] = 'Ticket was successfully created.'
        format.html { redirect_to(@ticket) }
        format.xml  { render :xml => @ticket, :status => :created, :location => @ticket }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @ticket = Ticket.find(params[:id])
  end
  
  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        flash[:notice] = 'Ticket was successfully updated.'
        format.html { redirect_to(@ticket) }
        format.xml  { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end
  
  protected
  
    def load_totals
      @totals = Ticket.totals(current_user)
    end

end