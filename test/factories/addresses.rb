Factory.define :address do |f|
  f.association :client
  f.full_address "154 Lewis St Hillsdale MI 49242"
end