class ChecklistItem < ActiveRecord::Base

  belongs_to :checklist
  
  validates_presence_of :checklist_id, :question, :answer_type
  
  before_update :update_completed_status
  
  def update_completed_status
    if self.send(self.answer_type) != ""
      self.completed = 1
    else
      self.completed = 2
    end
  end
  
end