class Iphone::ClientsController < ApplicationController
  before_filter :login_required
  layout 'iphone', :only => "home"
  
  def home
  end
  
  def show
    @client = Client.find(params[:id])
  end
  
  def index
    if params[:q]
      @clients = Client.search(params[:q], :limit => 100, :only => [:firstname, :lastname, :name])
    else
      @clients = []
    end
  end
  
end