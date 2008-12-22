class RadchecksController < ApplicationController
  before_filter :login_required
  layout nil

  def create
    @radcheck = Radcheck.new(params[:radcheck])
    if @radcheck.save
      flash[:notice] = "Dialup account created successfully!"
      redirect_to :back
    else
      flash[:notice] = "Suite could not create this dialup account."
      redirect_to :back
    end
  end
  
  def update
    @radcheck = Radcheck.find(params[:id])
    if @radcheck.update_attributes(params[:radcheck])
      flash[:notice] = "Dialup account updated successfully!"
      redirect_to :back
    else
      flash[:notice] = "Suite could not update this dialup account."
      redirect_to :back
    end
  end
  
  def destroy
    @radcheck = Radcheck.find(params[:id])
    if @radcheck.destroy
      flash[:notice] = "Dialup account deleted successfully."
      redirect_to :back
    else
      flash[:notice] = "Dialup account could not be deleted."
      redirect_to :back
    end
  end
  
end