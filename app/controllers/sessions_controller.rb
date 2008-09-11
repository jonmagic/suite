class SessionsController < ApplicationController
  before_filter :login_required, :only => :destroy
  layout 'clients'

  def new
  end

  def create
    self.current_user = User.authenticate(params[:username], params[:password])
    if logged_in?
      redirect_to clients_url
    else
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    redirect_to login_url
  end
end