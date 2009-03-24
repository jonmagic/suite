require File.dirname(__FILE__) + '/../test_helper'

class TicketTest < ActiveSupport::TestCase
  should_belong_to :client
  should_belong_to :user
  should_have_many :ticket_entries
  should_have_and_belong_to_many :devices
  should_have_many :checklists
  should_have_many :things
  should_validate_presence_of :client_id
  should_validate_presence_of :user_id
  should_validate_presence_of :description
  should_validate_presence_of :creator_id
  
  context "ticket#note_creation" do
    should "create note on ticket creation" do
      assert_difference "TicketEntry.count", 1 do
        Factory.create(:ticket)
      end
    end
    should "create note when updating ticket" do
      ticket = Factory.create(:ticket)
      assert_difference "TicketEntry.count", 1 do
        ticket.update_attributes(:active_on => Date.tomorrow)
      end
    end
    
  end
  
  context "ticket#status" do

    should "be active if not archived, completed, or scheduled" do
      ticket = Factory.create(:ticket, :active_on => nil)
      assert_equal ticket.status, "Open"
    end

    should "be scheduled if not archived or completed, and active_on is in the future" do
      ticket = Factory.create(:ticket, :active_on => 3.days.from(Now()))
      assert_contains ticket.status.array_it, "Scheduled"
    end
    
    should "be completed if completed_on is not nil and archived_on is nil" do
      ticket = Factory.create(:ticket, :completed_on => 1.day.ago)
      assert_contains ticket.status.array_it, "Completed"
    end
    
    should "be archived if archived_on is not nil" do
      ticket = Factory.create(:ticket, :archived_on => 1.day.ago)
      assert_contains ticket.status.array_it, "Archived"
    end

  end
  
  context "ticket#technician" do
    should "return the ticket user" do
      ticket = Factory.create(:ticket)
      assert_equal ticket.technician.name, ticket.user.name
    end
  end
  
  context "ticket#owner" do
    should "return ticket client" do
      ticket = Factory.create(:ticket)
      assert_equal ticket.owner.fullname, ticket.client.fullname
    end
  end

  context "Ticket#limit" do
    
  end

  context "Ticket#totals" do
    setup do
      (1..2).each do
        Factory.create(:ticket)
      end
      (1..3).each do
        Factory.create(:ticket, :active_on => Date.tomorrow)
      end
      (1..4).each do
        Factory.create(:ticket, :completed_on => 2.days.ago)
      end
      (1..5).each do
        Factory.create(:ticket, :archived_on => 5.days.ago)
      end
      @totals = Ticket.totals(User.find(1))
    end
    should "return proper number of open tickets" do
      assert_equal @totals[:open].to_i, 2
    end
    should "return proper number of scheduled tickets" do
      assert_equal @totals[:scheduled].to_i, 3
    end
    should "return proper number of completed tickets" do
      assert_equal @totals[:completed].to_i, 4
    end
    should "return proper number of all tickets not archived" do
      assert_equal @totals[:all].to_i, 9
    end
  end
  
  context "ticket#checklists" do
  end
  
end
