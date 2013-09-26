case Rails.env
when "development"
  namespace :db do
    desc "Fill database with sample data"
    task populate: :environment do
      User.create!(name: "user development",
                   email: "example@railstutorial.org")
      99.times do |n|
        name  = Faker::Name.name
        email = "example-#{n+1}@railstutorial.org"
        gender  = "male"
        fb_id  = "1"
        User.create!(name: name,
                     email: email,
                     gender: gender,
                     fb_id: fb_id)
      end

      Venue.create!(title: "Example User",
                   body: "example@railstutorial.org",
                   latitude: 0,
                   longitude: 0)
      99.times do |n|
        title  = Faker::Company.name
        body = Faker::Lorem.sentence(5)
        Venue.create!(title: title,
                     body: body,
                     latitude: 0,
                     longitude: 0)
      end 

      venues = Venue.all(limit: 6)
      50.times do |n|
        content = Faker::Lorem.sentence(5)
        venues.each { |venue| venue.posts.create!(content: content, user_id: (n+1))}
      end    

    end
  end

when "production"

  namespace :db do
    desc "Fill database with sample data"
    task populate: :environment do
      User.create!(name: "user production",
                   email: "example@krowdly.com")
      99.times do |n|
        name  = Faker::Name.name
        email = "example-#{n+1}@krowdly.com"
        gender  = "male"
        fb_id  = "1"
        User.create!(name: name,
                     email: email,
                     gender: gender,
                     fb_id: fb_id)
      end
  

    end
  end




end





