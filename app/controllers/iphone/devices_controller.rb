class Iphone::DevicesController < ApplicationController
  before_filter :login_required
  layout nil
  
  def show
    @device = Device.find(params[:id])
  end
  
  def index
    if params[:q]
      @devices = Device.search(params[:q], :include => [:client])
    else
      @devices = []
    end
  end
  
end