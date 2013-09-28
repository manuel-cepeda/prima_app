class Venue < ActiveRecord::Base
	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
	acts_as_voteable
	has_many :posts, dependent: :destroy
	has_many :vote_records
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
	def self.load_venues
	    book = Spreadsheet.open 'lib/venues.xls'
	    sheet1 = book.worksheet 0
	    
	    sheet1.each do |row|
			
	        #add venues from excel
	      Venue.create(:title => "#{row[0]}", :address => "#{row[1]}, #{row[4]},Santiago, Chile")
		  #Not overload Google API
	      sleep 0.25     
	    end	
	end



	def self.vote_venues

		20.times 
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


end
