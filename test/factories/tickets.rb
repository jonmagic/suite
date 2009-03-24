Factory.define :ticket do |f|
  f.association :client
  f.creator_id 1
  f.user_id 1
  f.sequence(:description) {|n| "some work needs done on computer ##{n}"} 
  f.active_on Date.today
  f.created_at 3.days.ago
  f.updated_at 1.days.ago
end