require 'httparty'

class GoogleMapsAPI
  include HTTParty
  base_uri "maps.google.com"
  default_params  :key      => "ABQIAAAApuX_5BYbKnzmBE3HKXu8yBTJQa0g3IQ9GZqIMmInSLzwtGDKaBT9NkNo6YIUV4Fa6Ff5q37qmXVoMg",
                  :output   => "json"

  def self.address_lookup(address)
    get('/maps/geo', :query => {:q => address})
  end

end