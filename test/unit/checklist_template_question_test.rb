require File.dirname(__FILE__) + '/../test_helper'

class ChecklistTemplateQuestionTest < ActiveSupport::TestCase
  should_belong_to :checklist_template
  
end