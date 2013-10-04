desc "This task is called by the Heroku scheduler add-on"
task :vote_venues => :environment do
  puts "creating votes..."
  Venue.vote_venues
  puts "done."
end


task :vote_slow_days_venues => :environment do
  puts "creating votes..."
  Venue.vote_slow_days_venues
  puts "done."
end