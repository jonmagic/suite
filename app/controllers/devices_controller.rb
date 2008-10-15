class DevicesController < ApplicationController
  before_filter :login_required
  layout 'devices', :except => [:details]

  def index
    @devices = Device.find(:all)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @devices }
      format.json  { render :json => @devices }
    end
  end
  
  def show
    @device = Device.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @device }
      format.json  { render :json => @device }
    end
  end
  
  def details
    @device = Device.find(params[:id])
    @ticket = Ticket.find(params[:ticket_id])
  end
  
  def add_to_ticket
    @ticket = Ticket.find(params[:ticket_id])
    @device = Device.find(params[:id])
    @ticket.devices << @device
    redirect_to ticket_path(@ticket)
  end
  
  def remove_from_ticket
    @ticket = Ticket.find(params[:ticket_id])
    @device = Device.find(params[:id])
    @ticket.devices.delete(@device)
    redirect_to ticket_path(@ticket)
  end
  
  def new
    @device = Device.new
    @clients = Client.find(:all)
  end
  
  def create
    @device = Device.new(params[:device])
    
    respond_to do |format|
      if @device.save
        flash[:notice] = 'Device was successfully created.'
        format.html { redirect_to(@device) }
        format.xml  { render :xml => @device, :status => :created, :location => @device }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @device.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @device = Device.find(params[:id])
    @clients = Client.find(:all)
  end
  
  def update
    @device = Device.find(params[:id])

    respond_to do |format|
      if @device.update_attributes(params[:device])
        flash[:notice] = 'Device was successfully updated.'
        format.html { redirect_to(@device) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @device.errors, :status => :unprocessable_entity }
      end
    end
  end

end
