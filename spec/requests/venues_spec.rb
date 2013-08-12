require 'spec_helper'

describe "venues pages" do
	
	subject {page}

	describe "show page" do

		let(:venue) {FactoryGirl.create(:venue)}
		before {visit venue_path(venue)}

		it {should have_title(venue.title)}
		it {should have_content(venue.body)}
	end	



end