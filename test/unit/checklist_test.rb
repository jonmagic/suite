require File.dirname(__FILE__) + '/../test_helper'

class ChecklistTest < ActiveSupport::TestCase
  should_belong_to :checklist_template
  should_belong_to :ticket
  should_belong_to :device
  should_have_many :checklist_items
  
  def setup
    @ct = Factory.create(:checklist_template)
    ctq1 = Factory.create(:checklist_template_question_string, :checklist_template => @ct)
    ctq2 = Factory.create(:checklist_template_question_boolean, :checklist_template => @ct)
    ctq3 = Factory.create(:checklist_template_question_integer, :checklist_template => @ct)
  end
  
  context "checklist#validates_associated" do
  end
  
  context "checklist#after_create" do
    should "build checklist items" do
      assert_difference "ChecklistItem.count", 3 do
        checklist = Checklist.create(valid_checklist_attributes)
      end
    end
  end

  context "checklist#after_update" do
    should "save checklist items" do
      checklist = return_saved_checklist
      checklist.checklist_items[0].string = "because I said so?"
      assert_equal return_saved_checklist(checklist).checklist_items[0].string, "because I said so?"
    end
  end
  
  context "checklist#before_update" do
    should "return completed" do
      checklist = return_saved_checklist
      checklist.checklist_items[0].string = "because I said so?"
      checklist.checklist_items[1].boolean = true
      checklist.checklist_items[2].integer = 5
      assert return_saved_checklist(checklist).complete?
    end
    
    should "return not complete" do
      checklist = return_saved_checklist
      assert !return_saved_checklist(checklist).complete?
    end
    
    should "set checklist to completed" do
      checklist = return_saved_checklist
      checklist.checklist_items[0].string = "because I said so?"
      checklist.checklist_items[1].boolean = true
      checklist.checklist_items[2].integer = 5
      checklist.checklist_items.each do |item|
        item.save
      end
      assert return_saved_checklist(checklist).completed
    end
  end
  
  def return_saved_checklist(checklist=nil)
    if checklist == nil
      checklist = Checklist.create(valid_checklist_attributes)
      checklist = Checklist.find(checklist.id)
      return checklist
    else
      checklist.save
      checklist = Checklist.find(checklist.id)
      return checklist
    end
  end
  
  def valid_checklist_attributes(options={})
    {
      :name => "sample checklist",
      :checklist_template => @ct
    }.merge(options)
  end
  
end