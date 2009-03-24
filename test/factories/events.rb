Factory.define :event do |f|
  f.recordable_type "sentry"
  f.recordable_id 1
  f.data "hello world"
end