class Iphone::DevicesController < ApplicationController
  before_filter :login_required
  layout nil
  
  def show
    @device = Device.find(params[:id])
  end
  
end