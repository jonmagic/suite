Factory.define :device do |d|
  d.name "Computer"
  d.description "Quentin's Laptop"
  d.association :device_type
  d.association :client
end

Factory.define :device_type do |dt|
  dt.identifier "555"
  dt.sequence(:description) { |n| "Device Type #{n}"}
end