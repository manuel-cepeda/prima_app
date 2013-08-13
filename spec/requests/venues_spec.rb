require 'spec_helper'

describe "venues pages" do
	
	subject {page}

	describe "show page" do

		let(:user) { FactoryGirl.create(:user) }
		let(:venue) { FactoryGirl.create(:venue) }
		let!(:m1) { FactoryGirl.create(:post, user: user, venue: venue, content: "Foo") }
		let!(:m2) { FactoryGirl.create(:post, user: user, venue: venue, content: "Bar") }

		before {visit venue_path(venue)}

		it {should have_title(venue.title)}
		it {should have_content(venue.body)}


		describe "posts" do

			it { should have_content(m1.content) }
			it { should have_content(m2.content) }
			it { should have_content(user.posts.count) }
		end


	end	



end