require 'spec_helper'

describe Post do

	let(:user) { FactoryGirl.create(:user)}
	let(:venue) { FactoryGirl.create(:venue)}

	before do
	  @post=user.posts.build(content: "Lorem Ipsum", venue_id: venue.id )
	end

	subject { @post }

	it {should respond_to(:content)}
	it {should respond_to(:user_id)}
	it {should respond_to(:venue_id)}
	
	it {should be_valid}

	describe "when user_id is not present" do
		before {@post.user_id =nil}
		it {should_not be_valid}
	end


	describe "when venue_id is not present" do
		before {@post.venue_id =nil}
		it {should_not be_valid}
	end

	describe "with blank content" do
	  before { @post.content = " " }
	  it { should_not be_valid }
	end

	describe "with content that is too long" do
	  before { @post.content = "a" * 141 }
	  it { should_not be_valid }
	end	

end
