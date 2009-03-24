require File.dirname(__FILE__) + '/../test_helper'

class ChecklistTemplateTest < ActiveSupport::TestCase
  should_have_many :checklist_template_questions
  should_have_and_belong_to_many :device_types
  
  context "checklist_template#validations" do
  end
  
  context "checklist_template#after_update" do
  end
  
end