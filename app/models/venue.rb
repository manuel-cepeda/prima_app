class Venue < ActiveRecord::Base
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

end
