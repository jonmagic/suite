namespace :jonmagic do
  desc "stuff I want to do"
  task(:rewind) do
    `cd #{RAILS_ROOT}`
    # puts "Deleting the dev database\n"
    # `rake db:reset`
    puts "migrating database up\n"
    `rake db:migrate`
    puts "bootstrapping the db"
    `./script/runner db/bootstrap.rb`
  end
end