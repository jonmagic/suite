module SchedulesHelper
  def schedule_active(schedule)
    schedule.active == true ? image_tag("/images/icons/star.png") : ""
  end
end