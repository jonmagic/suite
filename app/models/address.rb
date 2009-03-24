require 'lib/google_maps_api.rb'

class Address < ActiveRecord::Base
  include 
  belongs_to :client
  
  before_save :normalize_address
  
  def normalize_address
    if self.zip == nil
      # normalizing
      if address = Address.normalize_address(self.full_address)
        address["thoroughfare"] != nil ? self.thoroughfare = address["thoroughfare"] : self.thoroughfare = nil
        address["city"] != nil ? self.city = address["city"] : self.city = nil
        address["state"] != nil ? self.state = address["state"] : self.state = nil
        address["zip"] != nil ? self.zip = address["zip"] : self.zip = nil
        # puts "normalized!"
      end
    else
      # unable to normalize
      self.full_address = self.full_address
    end
  end

  protected
  
    def self.normalize_address(address)

      hash = GoogleMapsAPI.address_lookup(address)
      
      # puts hash.inspect
      
      return false unless hash["Status"]["code"] == 200
            
      address = {}
          
      if hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Locality"]
        # hash["Placemark"][0]["address"] != nil ? address["full_address"] = hash["Placemark"][0]["address"] : address["full_address"] = nil
        hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Locality"]["Thoroughfare"] != nil                    ? address["thoroughfare"] = hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Locality"]["Thoroughfare"]["ThoroughfareName"] : address["thoroughfare"] = nil
        hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Locality"]["LocalityName"] != nil                    ? address["city"]         = hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Locality"]["LocalityName"]                     : address["city"] = nil
        hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["AdministrativeAreaName"]   != nil                    ? address["state"]        = hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["AdministrativeAreaName"]                       : address["state"] = nil
        hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Locality"]["PostalCode"] != nil                      ? address["zip"]          = hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Locality"]["PostalCode"]["PostalCodeNumber"]   : address["zip"] = nil
      elsif hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]
        # hash["Placemark"][0]["address"] != nil ? address["full_address"] = hash["Placemark"][0]["address"] : address["full_address"] = nil
        hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Thoroughfare"] != nil                      ? address["thoroughfare"] = hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Thoroughfare"]["ThoroughfareName"] : address["thoroughfare"] = nil
        hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["LocalityName"] != nil                      ? address["city"]         = hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["LocalityName"]                     : address["city"] = nil
        hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["AdministrativeAreaName"] != nil            ? address["state"]        = hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["AdministrativeAreaName"]           : address["state"] = nil
        hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["PostalCode"] != nil                        ? address["zip"]          = hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["PostalCode"]["PostalCodeNumber"]   : address["zip"] = nil
      else
        # puts "failed to get anything useful"
        return false
      end
      return address
    end
    
end