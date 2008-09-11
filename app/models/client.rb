class Client < ActiveRecord::Base
  
  has_many :devices, :dependent => :destroy
  has_many :tickets
  
  has_many :phones, :dependent => :destroy
  has_many :emails, :dependent => :destroy
  has_many :addresses, :dependent => :destroy

  validates_associated :phones, :emails, :addresses
  
  after_update :save_phones, :save_emails, :save_addresses
  
  def new_phone_attributes=(phone_attributes)
    phone_attributes.each do |attributes|
      phones.build(attributes)
    end
  end
  def new_email_attributes=(email_attributes)
    email_attributes.each do |attributes|
      emails.build(attributes)
    end
  end
  def new_address_attributes=(address_attributes)
    address_attributes.each do |attributes|
      addresses.build(attributes)
    end
  end
  
  def existing_phone_attributes=(phone_attributes)
    phones.reject(&:new_record?).each do |phone|
      attributes = phone_attributes[phone.id.to_s]
      if attributes
        phone.attributes = attributes
      else
        phones.delete(phone)
      end
    end
  end
  def existing_email_attributes=(email_attributes)
    emails.reject(&:new_record?).each do |email|
      attributes = email_attributes[email.id.to_s]
      if attributes
        email.attributes = attributes
      else
        emails.delete(email)
      end
    end
  end
  def existing_address_attributes=(address_attributes)
    addresses.reject(&:new_record?).each do |address|
      attributes = address_attributes[address.id.to_s]
      if attributes
        address.attributes = attributes
      else
        addresses.delete(address)
      end
    end
  end
  
  def save_phones
    phones.each do |phone|
      phone.save(false)
    end
  end
  def save_emails
    emails.each do |email|
      email.save(false)
    end
  end
  def save_addresses
    addresses.each do |address|
      address.save(false)
    end
  end
  
  def company_name
    if self.belongs_to != nil
      company = Client.find(self.belongs_to)
      return company.name
    else
      return ""
    end
  end

  def fullname
    if self.company == true
      return self.name
    elsif self.firstname != nil || self.lastname != nil
      return "#{self.firstname} #{self.lastname}"
    else
      return "#{self.firstname}"
    end
  end
  
  def primary_phone
    if phone = Phone.find(:first, :conditions => {:client_id => self.id, :ordinal => 0}) then phone.number else "" end
  end
  def primary_email
    if email = Email.find(:first, :conditions => {:client_id => self.id, :ordinal => 0}) then email.address else "" end
  end
  def primary_address
    if address = Address.find(:first, :conditions => {:client_id => self.id, :ordinal => 0}) then address.full_address else "" end
  end

end
