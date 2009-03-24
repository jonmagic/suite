Factory.define :user do |f|
  f.email "jon@example.com"
  f.name "Jonathan Jingle"
  f.salt "356a192b7913b04c54574d18c28d46e6395428ab"
  f.crypted_password "234dc8b30f5473f155f86caa9749d4ce9404a737"
  f.created_at 5.days.ago
  f.remember_token_expires_at 1.days.from_now
  f.remember_token "77de68daecd823babbb58edb1c8e14d7106e83bb"
  f.association :client
end

Factory.define :george, :parent => :user do |f|
  f.email "george@example.com"
  f.name "George Jones"
end