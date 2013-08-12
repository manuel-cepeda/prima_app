module VenuesHelper

  def venues_by_plus_minus_vote(time)

	case time.to_i # a_variable is the variable we want to compare
	when 1    #compare to 1
	   @items = Venue.plusminus_tally.limit(30).
                where(created_at: 1.hours.ago..Time.now)
	when 2    #compare to 2
	   @items = Venue.plusminus_tally.limit(30).
                where(created_at: 24.minutes.ago..Time.now)
	when 3    #compare to 3
	   @items = Venue.plusminus_tally.limit(30)
	else
	   @items = Venue.plusminus_tally.limit(30).
                where(created_at: 1.hours.ago..Time.now)
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
