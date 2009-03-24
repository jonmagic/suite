Factory.define :sentry do |f|
  f.state true
  f.association :device
  f.association :schedule
  f.association :goggle
  f.survey_interval 15
  f.notifications_to_send 5
  f.maximum_notify_frequency 60
end