module VenuesHelper

  def venues_by_plus_minus_vote(time)

    @default = Venue.plusminus_tally.limit(30).where('votes.updated_at > ?', 3.hours.ago)

	case time.to_i # a_variable is the variable we want to compare
	when 1    #compare to 1
	   @default
	when 2    #compare to 3
	   @items = Venue.plusminus_tally.limit(30)
	else
     @default
	end

 
   

  end

  def venues_by_total_votes
 
    @items = Venue.tally(
    :at_least => 1,      
    :limit => 20,
    :order => 'vote_count desc'
  )

  end


end
