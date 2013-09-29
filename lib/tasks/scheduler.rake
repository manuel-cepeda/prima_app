desc "This task is called by the Heroku scheduler add-on"
task :vote_venues => :environment do
  puts "creating votes..."
  Venue.vote_venues
  puts "done."
end
