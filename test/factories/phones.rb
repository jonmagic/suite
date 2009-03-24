Factory.define :phone do |f|
  f.number "679-555-1212"
  f.association :client
end