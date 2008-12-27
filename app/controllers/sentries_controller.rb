class SentriesController < ApplicationController
  before_filter :login_required, :except => 'index'
  skip_before_filter :verify_authenticity_token, :only => 'index'
  before_filter :http_basic_authenticate, :only => 'index'
  layout nil
  
  def index
    if params[:device_id]
      @sentries = Sentry.find(:all, :conditions => {:device_id => params[:device_id]})
      respond_to do |format|
        format.json # index.json.erb
      end
    end  
  end
  
  def edit
    @sentry = Sentry.find(params[:id])
  end

  def create
    @sentry = Sentry.new(params[:sentry])
    if @sentry.save
      flash[:notice] = "Sentry created successfully."
      redirect_to :back
    else
      flash[:notice] = "Sentry could not be created."
      redirect_to :back
    end
  end
  
  def update
    @sentry = Sentry.find(params[:id])
    if @sentry.update_attributes(params[:sentry])
      flash[:notice] = "Sentry updated successfully."
      redirect_to :back
    else
      flash[:notice] = "Sentry could not be updated."
      redirect_to :back
    end
  end
  
  def destroy
    @sentry = Sentry.find(params[:id])
    @sentry.destroy
    redirect_to :back
  end
  
  protected

    def http_basic_authenticate
      authenticate_or_request_with_http_basic do |username, password|
        # after testing uncomment the following line and comment out the test line
        username == APP_CONFIG[:event_api_username] && password == APP_CONFIG[:event_api_password]
        # username == "test" && password == "test"
      end
    end
end