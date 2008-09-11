class DevicesController < ApplicationController
  before_filter :login_required
  layout 'devices'

  def index
    @devices = Device.find(:all)
  end
  
  def show
    @device = Device.find(params[:id])
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
