Factory.define :schedule do |f|
  f.name "24x7"
  f.active true
  f.user_id 1
  f.start_time "7am"
  f.end_time "10pm"
end