class Iphone::DevicesController < ApplicationController
  before_filter :login_required
  layout nil
  
  def show
    @device = Device.find(params[:id])
  end
  
  def index
    if params[:client_id]
      @devices = Device.find(:all, :conditions => {:client_id => params[:client_id]})
    elsif params[:ticket_id]
      @devices = Ticket.find(params[:ticket_id]).devices
    else
      if params[:q]
        @devices = Device.search(params[:q], :include => [:client])
      else
        @devices = []
      end
    end
  end
  
end