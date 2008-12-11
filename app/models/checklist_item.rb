class ChecklistItem < ActiveRecord::Base

  belongs_to :checklist
  
  validates_presence_of :checklist_id, :question, :answer_type
  
  before_update :update_completed_status
  
  def update_completed_status
    self.complete? ? self.completed = true : self.completed = false
  end
  
  def complete?
    !self.send(self.answer_type).blank?
  end
  
end