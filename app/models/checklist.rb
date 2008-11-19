class Checklist < ActiveRecord::Base

  belongs_to :checklist_template
  belongs_to :ticket
  belongs_to :device

  has_many :checklist_items, :dependent => :destroy

  validates_associated :checklist_items

  after_create :build_checklist_items
  after_update :save_checklist_items
  
  def new_checklist_item_attributes=(checklist_item_attributes)
    checklist_item_attributes.each do |attributes|
      checklist_items.build(attributes)
    end
  end
  
  def existing_checklist_item_attributes=(checklist_item_attributes)
    checklist_items.reject(&:new_record?).each do |checklist_item|
      attributes = checklist_item_attributes[checklist_item.id.to_s]
      if attributes
        checklist_item.attributes = attributes
      else
        checklist_items.delete(checklist_item)
      end
    end
  end
  
  def save_checklist_items
    checklist_items.each do |question|
      question.save(false)
    end
  end
  
  def build_checklist_items
    template = ChecklistTemplate.find(self.checklist_template_id)
    template.checklist_template_questions.each do |question|
      ChecklistItem.create(:checklist => self, :question => question.question, :answer_type => question.answer_type)
    end
  end
  
end
