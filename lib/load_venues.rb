	    book = Spreadsheet.open 'lib/venues.xls'
	    sheet1 = book.worksheet 0
	    
	    sheet1.each do |row|
			
	        #add venues from excel
	      Venue.create(:title => "#{row[0]}", :address => "#{row[1]}, #{row[4]},Santiago, Chile")
		  #Not overload Google API
	      sleep 0.25     
	    end	