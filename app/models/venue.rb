class Venue < ActiveRecord::Base
  include SessionsHelper
	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
	acts_as_voteable
	has_many :posts, dependent: :destroy
	has_many :vote_records
	has_many :ratings
	belongs_to :user
	validates :title, presence: true, length: {maximum: 60}
	searchable  do
		
		text :title
	end

	def get_positive_votes

    where1= self.votes.where('votes.vote = ?', true)
    where2= self.votes.where('votes.updated_at > ?', 3.hours.ago)
    votes=where1 & where2

	end	

	def get_negative_votes

    where1= self.votes.where('votes.vote = ?', false)
    where2= self.votes.where('votes.updated_at > ?', 3.hours.ago)
    votes=where1 & where2

	end

	def get_total_votes

    votes = self.votes.where('votes.updated_at > ?', 3.hours.ago)


	end	

	#for security reason check if is safe to run this with rails runner 
	#heroku run rails runner Venue.load_venues 
	def self.load_venues
	    book = Spreadsheet.open 'lib/venues.xls'
	    sheet1 = book.worksheet 0
	    
	    sheet1.each do |row|
			user=User.find(1)
	        #add venues from excel
	        @venue = user.venues.build(:title => "#{row[0]}", :address => "#{row[1]}, #{row[4]},Santiago, Chile")
	     	@venue.save
		  #Not overload Google API
	      sleep 1     
	    end	
	end



	def self.vote_venues

		20.times do
			  venue_id=rand(1..1200).to_i
		      votes_number_positive=rand(1..10).to_i
		      votes_number_negative=rand(1..5).to_i

		      i = 0
		      until i == votes_number_positive
		        i += 1
		        User.find(i+7).vote_exclusively_for(@venue = Venue.find(venue_id))
		      end

		      i = 0
		      until i == votes_number_negative
		        i += 1
		        User.find(i+30).vote_exclusively_against(@venue = Venue.find(venue_id))
		      end
		end


	end

	def self.vote_slow_days_venues

		20.times do
			  venue_id=rand(1..1200).to_i
		      votes_number_positive=rand(1..2).to_i
		      votes_number_negative=rand(1..5).to_i

		      i = 0
		      until i == votes_number_positive
		        i += 1
		        User.find(i+7).vote_exclusively_for(@venue = Venue.find(venue_id))
		      end

		      i = 0
		      until i == votes_number_negative
		        i += 1
		        User.find(i+30).vote_exclusively_against(@venue = Venue.find(venue_id))
		      end
		end


	end

	def average_rating

		rating=ratings.where('updated_at > ?', 5.hours.ago)
		ratings_count = rating.count


		if ratings_count == 0
			ratings_count=1;
		end

	  rating.sum(:score) / ratings_count
    end  


	def current_user_rating(current_user_id)

		ratings.where(:user_id => current_user_id, :venue_id => self.id).first.score

 			

    end  



  






end
