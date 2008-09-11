require 'uri'
require 'net/http'
require 'rubygems'
require 'json'

def getLocation(address)
  key = "ABQIAAAApuX_5BYbKnzmBE3HKXu8yBTJQa0g3IQ9GZqIMmInSLzwtGDKaBT9NkNo6YIUV4Fa6Ff5q37qmXVoMg"
  output = "json"
  baseUrl = "http://maps.google.com/maps/geo?"
  url = "#{baseUrl}q=#{address}&output=#{output}&key=#{key}"

  # hash = `curl -H "Accept: application/json" "http://maps.google.com/maps/geo?q=#{address}&output=#{output}&key=#{key}"`
  response = Net::HTTP.get_response(URI.parse(url))
  data = response.body
  hash = JSON.parse(data)
  puts "\n"
  puts hash["Placemark"][0]["address"].inspect
  puts "\n"
  # Street
  puts hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["SubAdministrativeArea"]["Locality"]["Thoroughfare"]["ThoroughfareName"]
  # City
  puts hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["SubAdministrativeArea"]["Locality"]["LocalityName"]
  # State
  puts hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["AdministrativeAreaName"]
  # Zip
  puts hash["Placemark"][0]["AddressDetails"]["Country"]["AdministrativeArea"]["SubAdministrativeArea"]["Locality"]["PostalCode"]["PostalCodeNumber"]
end

getLocation(URI.encode("316 West Blvd South Elkhart IN 46514"))