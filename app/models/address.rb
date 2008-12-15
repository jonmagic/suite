class Address < ActiveRecord::Base
  belongs_to :client
  
  before_save :normalize_address
  
  def normalize_address
    # puts "normalizing"
    if address = getLocation(self.full_address)
      address["full_address"] != nil ? self.full_address = address["full_address"] : self.full_address = self.full_address
      address["thoroughfare"] != nil ? self.thoroughfare = address["thoroughfare"] : self.thoroughfare = nil
      address["city"] != nil ? self.city = address["city"] : self.city = nil
      address["state"] != nil ? self.state = address["state"] : self.state = nil
      address["zip"] != nil ? self.zip = address["zip"] : self.zip = nil
      # puts "normalized!"
    else
      # puts "unable to normalize"
      self.full_address = self.full_address
    end
  end

  protected
  
    def getLocation(address)
      puts "getting location"
      key = "ABQIAAAApuX_5BYbKnzmBE3HKXu8yBTJQa0g3IQ9GZqIMmInSLzwtGDKaBT9NkNo6YIUV4Fa6Ff5q37qmXVoMg"
      output = "json"
      host = "maps.google.com"
      address = URI.encode(address)
      path = "/maps/geo"
      query = "q=#{address}&output=#{output}&key=#{key}"
      puts "http://#{host}#{path}?#{query}"
      uri = URI::HTTP.build({:host => host, :path => path, :query => query})
      
      
      data = Net::HTTP.get(uri)
      hash = JSON.parse(data)
      puts hash.inspect
      
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