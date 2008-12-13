class EventsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :http_basic_authenticate

  def create
    @event = Event.new
    @event.recordable_id = params[:sentry_id]
    @event.recordable_type = params[:type]
    @event.data = params[:data]    
    respond_to do |format|
      if @event.save
        format.json  { render :json => @event, :status => "Created" }
      else
        format.json { render :json => @event.errors, :status => :unprocessable_entity}
      end
    end
  end

  protected

    def http_basic_authenticate
      authenticate_or_request_with_http_basic do |username, password|
        # after testing uncomment the following line and comment out the test line
        # username == APP_CONFIG[:event_api_username] && password == APP_CONFIG[:event_api_password]
        username == "test" && password == "test"
      end
    end

end