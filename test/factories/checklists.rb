Factory.define :checklist_template do |ct|
  ct.sequence(:name) {|n| "Checklist Template ##{n}"} 
end

Factory.define :checklist_template_question do |ctq|
  ctq.association :checklist_template
end

Factory.define :checklist_template_question_string, :parent => :checklist_template_question do |q|
  q.question "how do I know you are right?"
  q.answer_type "string"
end

Factory.define :checklist_template_question_boolean, :parent => :checklist_template_question do |q|
  q.question "is the world round?"
  q.answer_type "boolean"
end

Factory.define :checklist_template_question_integer, :parent => :checklist_template_question do |q|
  q.question "how many houses do you own?"
  q.answer_type "integer"
end