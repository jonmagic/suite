Factory.define :email do |f|
  f.address "quentin@example.com"
  f.association :client
end
