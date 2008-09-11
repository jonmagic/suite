class TicketsController < ApplicationController
  before_filter :login_required
  
  def index
    @tickets = Ticket.find(:all)
  end

  def show
    @ticket = Ticket.find(params[:id])
    @description = RedCloth.new(@ticket.description)
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
  
end
