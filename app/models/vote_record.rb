class VoteRecord < ActiveRecord::Base

	belongs_to :user
	belongs_to :venue

	 def self.record_one_vote(venue, user, vote_value)
	    some_vote = find_by_question_id_and_voter_id(question.id, voter.id)
	    if some_vote == nil
	      new_vote = VoteRecord.new
	      new_vote.user_id = user.id
	      new_vote.venue_id = venue.id
	      #logger.log "Voter #{voter.id} answering #{vote_value} to question #{question.id}"
	      if vote_value == 1
	        new_vote.is_yes = 1
	      elsif vote_value == 0
	        new_vote.is_yes = 0
	        # otherwise, value is NULL (for abstention)
	      end
	      new_vote.save
	    else
	      if vote_value == 1
	        new_vote.is_yes = 1
	      elsif vote_value == 0
	        new_vote.is_yes = 0
	    end
	  end


end
