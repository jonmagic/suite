class User < ActiveRecord::Base
  
  has_many :tickets

  def self.authenticate(username, password)
    return false if username.blank? || password.blank?
    Google::Base.establish_connection(username, password)
    User.find_or_create_by_username(username)
  rescue Google::LoginError
    false
  end
  
  class SessionsController < ApplicationController
    before_filter :login_required, :only => :destroy
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

end