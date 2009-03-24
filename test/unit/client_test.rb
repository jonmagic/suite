require File.dirname(__FILE__) + '/../test_helper'

class ClientTest < ActiveSupport::TestCase
  should_have_one :user
  should_have_many :devices
  should_have_many :tickets
  should_have_many :things
  should_have_many :phones
  should_have_many :emails
  should_have_many :addresses
  # should_have_one :radcheck
  
  context "client#validates_has_a_name" do
    should "not save if name, firstname, and lastname are blank" do
      client = Factory.build(:client, :name => nil, :firstname => nil, :lastname => nil)
      assert !client.save
    end
  end
  
  context "client#company_name" do
    should "return associated company name" do
      company = Factory.create(:client, :name => "XYZ Enterprises", :firstname => nil, :lastname => nil, :company => true)
      client = Factory.create(:client, :belongs_to => company.id)
      assert_equal client.company_name, company.name
    end
    should "return empty string if there is no associated company" do
      client = Factory.create(:client)
      assert_equal client.company_name, ""
    end
  end
  
  context "client#fullname" do
    should "return company name" do
      company = Factory.create(:client, :name => "XYZ Enterprises", :firstname => nil, :lastname => nil, :company => true)
      assert_equal company.fullname, company.name
    end
    should "return firstname lastname" do
      client = Factory.create(:client)
      assert_equal client.fullname, "#{client.firstname} #{client.lastname}"
    end
    should "return somename" do
      client = Factory.create(:client, :firstname => "Bob", :lastname => nil, :name => nil)
      assert_equal client.fullname, "Bob"
    end
  end
  
  context "client#lastfirst" do
    should "return company name" do
      company = Factory.create(:client, :name => "XYZ Enterprises", :firstname => nil, :lastname => nil, :company => true)
      assert_equal company.lastfirst, company.name
    end
    should "return lastname, firstname" do
      client = Factory.create(:client)
      assert_equal client.lastfirst, "#{client.lastname}, #{client.firstname}"
    end
    should "return somename" do
      client = Factory.create(:client, :firstname => "Bob", :lastname => nil, :name => nil)
      assert_equal client.lastfirst, "Bob"
    end
  end
  
  context "client#somename" do
    should "return lastname" do
      client = Factory.create(:client, :firstname => nil)
      assert_equal client.somename, client.lastname
    end
    should "return firstname" do
      client = Factory.create(:client, :lastname => nil)
      assert_equal client.somename, client.firstname
    end
  end
  
  context "client#type" do
    should "return company" do
      company = Factory.create(:client, :name => "XYZ Enterprises", :firstname => nil, :lastname => nil, :company => true)
      assert_equal company.type, "company"
    end
    should "return person" do
      client = Factory.create(:client)
      assert_equal client.type, "person"
    end
  end
  
  context "client#primary's" do
    setup do
      @client = Factory.create(:client)
    end
    should "return clients primary phone number" do
      phone1 = Factory.create(:phone, :client_id => @client.id, :number => "510-555-1212")
      phone2 = Factory.create(:phone, :client_id => @client.id, :number => "510-555-5555")
      assert_equal @client.primary_phone, phone1.number
    end
    should "return an empty string for clients primary phone number" do
      assert_equal @client.primary_phone, ""
    end
    should "return clients primary email address" do
      email1 = Factory.create(:email, :client_id => @client.id, :address => "quentin@humble.com")
      email2 = Factory.create(:email, :client_id => @client.id, :address => "quire@humble.com")
      assert_equal @client.primary_email, email1.address
    end
    should "return an empty string for clients primary email address" do
      assert_equal @client.primary_email, ""
    end
    should "return clients primary street address" do
      address1 = Factory.create(:address, :client_id => @client.id, :full_address => "32 S Howell St Hillsdale MI 49242")
      address2 = Factory.create(:address, :client_id => @client.id, :full_address => "154 Lewis St Hillsdale MI 49242")
      assert_equal @client.primary_address, address1.full_address
    end
    should "return an empty string for clients primary street address" do
      assert_equal @client.primary_address, ""
    end
  end
  
  context "client#open_tickets" do
    setup do
      @client = Factory.create(:client)
      @ticket = Ticket.create(:client_id => @client.id)
    end

    should "return clients tickets" do
      assert_not_nil @client.open_tickets
    end
  end
  
  
end