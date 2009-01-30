class Report::TimeSheetController < ApplicationController
  before_filter :login_required
  layout 'reports'
  
  def index
    if params[:start_date] && params[:end_date] && params[:technician]
      start_date = params[:start_date] + " 00:00:00"
      end_date = params[:end_date] + " 23:59:59"
      @total = 0.0
      entries = TicketEntry.find(:all, :conditions => {:creator_id => params[:technician], :billable => true, :created_at.gte => start_date, :created_at.lte => end_date})
      entries.each do |entry|
        @total += entry.time
      end
      @total = @total/60
    end
  end
  
  def show
  end
end