class ChecklistTemplate < ActiveRecord::Base

  has_many :checklist_template_questions, :dependent => :destroy
  has_and_belongs_to_many :device_types
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_associated :checklist_template_questions
  
  after_update :save_checklist_template_questions
  
  def new_checklist_template_question_attributes=(checklist_template_question_attributes)
    checklist_template_question_attributes.each do |attributes|
      checklist_template_questions.build(attributes)
    end
  end
  
  def existing_checklist_template_question_attributes=(checklist_template_question_attributes)
    checklist_template_questions.reject(&:new_record?).each do |checklist_template_question|
      attributes = checklist_template_question_attributes[checklist_template_question.id.to_s]
      if attributes
        checklist_template_question.attributes = attributes
      else
        checklist_template_questions.delete(checklist_template_question)
      end
    end
  end
  
  def save_checklist_template_questions
    checklist_template_questions.each do |question|
      question.save(false)
    end
  end
  
end
