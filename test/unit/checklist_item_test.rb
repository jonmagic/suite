require File.dirname(__FILE__) + '/../test_helper'

class ChecklistItemTest < ActiveSupport::TestCase
  should_belong_to :checklist
  
  context "checklist_item#validations" do
  end
  
  context "checklist_item#before_update" do
  end
  
end