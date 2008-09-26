class TicketsController < ApplicationController
  before_filter :login_required
  before_filter :load_totals, :except => [:create, :update]
  
  def index
    @tickets = Ticket.limit(params[:status], params[:scope], current_user)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tickets }
      format.json  { render :json => @tickets }
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
    @ticket_entry = TicketEntry.new
    @description = RedCloth.new(@ticket.description)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ticket }
      format.json  { render :json => @ticket }
    end
  end
  
  def new
    @ticket = Ticket.new
    @clients = Client.find(:all)
    @users = User.find(:all)
    @groups = ["Sales", "Service", "Billing"]
  end
  
  def create
    @ticket = Ticket.new(params[:ticket])
    
    respond_to do |format|
      if @ticket.save
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
    @clients = Client.find(:all)
    @users = User.find(:all)
    @groups = ["Sales", "Service", "Billing"]
  end
  
  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        flash[:notice] = 'Ticket was successfully updated.'
        format.html { redirect_to(@ticket) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  protected
  
    def load_totals
      @totals = Ticket.totals(current_user)
    end

end
