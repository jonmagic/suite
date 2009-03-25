class SchedulesController < ApplicationController
  before_filter :login_required
  layout "settings"

  def index
    @schedules = Schedule.find(:all, :order => "name")
  end
  
  def new
    @schedule = Schedule.new
  end
  
  def create
    @schedule = Schedule.new(params[:schedule])
    if @schedule.save
      flash[:notice] = "Schedule created successfully!"
      redirect_to schedules_url
    else
      flash[:notice] = @schedule.errors.to_s
      redirect_to new_schedule_url
    end
  end
  
  def edit
    @schedule = Schedule.find(params[:id])
  end
  
  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update_attributes(params[:schedule])
      flash[:notice] = "Schedule updated successfully!"
      redirect_to schedules_url
    else
      flash[:notice] = @schedule.errors.to_s
      redirect_to edit_schedule_url(@schedule)
    end
  end
end