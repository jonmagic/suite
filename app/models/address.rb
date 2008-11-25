class Address < ActiveRecord::Base
  belongs_to :client
  
  before_save :normalize_address
  
  def normalize_address
    # puts "normalizing"
    if address = getLocation(self.full_address)
      self.full_address = address["full_address"]
      self.thoroughfare = address["thoroughfare"]
      self.city = address["city"]
      self.state = address["state"]
      self.zip = address["zip"]
      # puts "normalized!"
    else
      # puts "unable to normalize"
      self.full_address = self.full_address
    end
  end

  protected
  
    def getLocation(address)
      # puts "getting location"
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
      # puts hash.inspect
      
      return false unless hash["Status"]["code"] == 200
      return false
            
      address = {}
          
      if hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Locality"]
        address["full_address"] = hash["Placemark"][0]["address"] if hash["Placemark"][0]["address"]["Thoroughfare"]
        address["thoroughfare"] = hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Locality"]["Thoroughfare"]["ThoroughfareName"] if hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Locality"]["Thoroughfare"]["ThoroughfareName"]
        address["city"]         = hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Locality"]["LocalityName"] if hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Locality"]["LocalityName"]
        address["state"]        = hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["AdministrativeAreaName"] if hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["AdministrativeAreaName"]
        address["zip"]          = hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Locality"]["PostalCode"]["PostalCodeNumber"] if hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Locality"]["PostalCode"]["PostalCodeNumber"]
      elsif hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]
        address["full_address"] = hash["Placemark"][0]["address"] if hash["Placemark"][0]["address"]["Thoroughfare"]
        address["thoroughfare"] = hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Thoroughfare"]["ThoroughfareName"] if hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Locality"]["Thoroughfare"]["ThoroughfareName"]
        address["city"]         = hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["LocalityName"] if hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Locality"]["LocalityName"]
        address["state"]        = hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["AdministrativeAreaName"] if hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["AdministrativeAreaName"]
        address["zip"]          = hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["PostalCode"]["PostalCodeNumber"] if hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["Locality"]["PostalCode"]["PostalCodeNumber"]
      else
        return false
      end
      return address
    end
    
end