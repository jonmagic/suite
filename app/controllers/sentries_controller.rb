class SentriesController < ApplicationController
  before_filter :login_required
  layout nil
  
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
end