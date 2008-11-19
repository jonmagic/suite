class DeviceTypesController < ApplicationController
  layout 'devices'

  def index
    @device_types = DeviceType.find(:all)
  end
  
  def new
    @device_type = DeviceType.new
  end
  
  def create
    @device_type = DeviceType.new(params[:device_type])
    
    if @device_type.save
      flash[:notice] = 'Device type was successfully created.'
      redirect_to '/device_types'
    else
      flash[:notice] = 'Device type could not be created.'
      redirect_to '/device_types'
    end
  end
  
  def edit
    @device_type = DeviceType.find(params[:id])
  end
  
  def update
    @device_type = DeviceType.find(params[:id])
    
    if @device_type.update_attributes(params[:device_type])
      flash[:notice] = 'Device type was successfully updated.'
      redirect_to '/device_types'
    else
      flash[:notice] = 'Device type was screwy.'
      redirect_to '/device_types'
    end
  end

end