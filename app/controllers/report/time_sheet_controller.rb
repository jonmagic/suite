class Report::TimeSheetController < ApplicationController
  before_filter :login_required
  layout 'reports'
  
  def index
    if params[:start_date] && params[:end_date]
      start_date = params[:start_date] + " 00:00:00"
      end_date = params[:end_date] + " 23:59:59"
      entries = TicketEntry.find(:all, :conditions => {:created_at.gte => start_date, :created_at.lte => end_date, :time.gt => 0})
      technicians = Hash.new {|h,k| h[k] = {:name => User.find(k).name, :onsite => 0.0, :instore => 0.0, :remote => 0.0, :system_build => 0.0, :drive_time => 0.0, :billable => 0.0, :non_billable => 0.0}}
      entries.each do |entry|
        if entry.labor_type == "Onsite"
          technicians[entry.creator_id][:onsite] += entry.time
        elsif entry.labor_type == "Instore"
          technicians[entry.creator_id][:instore] += entry.time
        elsif entry.labor_type == "Remote"
          technicians[entry.creator_id][:remote] += entry.time
        elsif entry.labor_type == "System Build"
          technicians[entry.creator_id][:system_build] += entry.time
        end
        if entry.billable == true
          technicians[entry.creator_id][:billable] += entry.time
          if !entry.drive_time.blank?
            technicians[entry.creator_id][:drive_time] += entry.drive_time
            technicians[entry.creator_id][:billable] += entry.drive_time
          end
        else
          technicians[entry.creator_id][:non_billable] += entry.time
          if !entry.drive_time.blank?
            technicians[entry.creator_id][:drive_time] += entry.drive_time
            technicians[entry.creator_id][:non_billable] += entry.drive_time
          end
        end
      end
      @technicians = technicians.values
      @start_date = params[:start_date]
      @end_date = params[:end_date]
    end
  end
  
  def show
  end
  
end