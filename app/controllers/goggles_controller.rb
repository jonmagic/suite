class GogglesController < ApplicationController
  before_filter :login_required
  layout "settings"

  def index
    @goggles = Goggle.find(:all, :order => "name")
  end
  
  def new
    @goggle = Goggle.new
  end
  
  def create
    @goggle = Goggle.new(params[:goggle])
    if @goggle.save
      flash[:notice] = "Goggle created successfully!"
      redirect_to goggles_url
    else
      flash[:notice] = @goggle.errors.to_s
      redirect_to new_goggle_url
    end
  end
  
  def edit
    @goggle = Goggle.find(params[:id])
  end
  
  def update
    @goggle = Goggle.find(params[:id])
    if @goggle.update_attributes(params[:goggle])
      flash[:notice] = "Goggle updated successfully!"
      redirect_to goggles_url
    else
      flash[:notice] = @goggle.errors.to_s
      redirect_to edit_goggle_url(@goggle)
    end
  end
  
  def destroy
    @goggle = Goggle.find(params[:id])
    @goggle.destroy

    respond_to do |format|
      format.html { redirect_to(goggles_url) }
      format.xml  { head :ok }
    end
  end
  
end