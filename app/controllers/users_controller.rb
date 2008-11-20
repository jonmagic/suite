class UsersController < ApplicationController
  before_filter :login_required
  layout 'users', :except => [:show]
  consider_local "208.78.101.98"

  def show
    @user = User.find(current_user.id)
    @password = Password.new
  end
  
  def update
    @user = User.find(params[:id])
    @client = Client.find(@user.client_id)
    if @user.update_attributes(params[:user])
      redirect_to client_url(@client)
      flash[:notice] = "Your avatar has been updated"
    else
      flash[:error] = "Your avatar has not been updated"
      redirect_to client_url(@client)
    end
  end

  def new
    @user = User.new
    @client = Client.find(params[:client_id])
    @random = "mo0nk3yp1ts"
  end
 
  def create
    # logout_keeping_session!
    tech_role = Role.find_by_name("technician")
    @user = User.new(params[:user])
    @user.register!
    success = @user
    if success && @user.errors.empty?
      @user.client_id = params[:user][:client_id]
      @user.activate!
            
      @password = Password.new(:email => @user.email)
      @password.user = @user
      @password.save
      PasswordMailer.deliver_create_password(@password)
      
      @user.roles << tech_role

      redirect_to "/clients/#{@user.client_id.to_s}"
    else
      redirect_to "/clients/#{@user.client_id.to_s}"
    end
  end

  def activate
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when !params[:activation_code].blank? && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to  login_url
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default root_url
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default root_url
    end
  end
end
