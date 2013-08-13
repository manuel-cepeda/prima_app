require 'spec_helper'

describe User do

	before {@user=User.new(name: "Example User", email: "user@example.com")}

	subject {@user}

	it {should respond_to(:name)}
	it {should respond_to(:email)}
	it {should respond_to(:fb_id)}
	it {should respond_to(:gender)}
	it { should respond_to(:posts) }

	it {should be_valid}

	describe "when name is not present" do

		before do
		  @user.name=""
		end
        
        it {should_not be_valid}
	end	

	describe "when email is not present" do

		before do
		  @user.email=""
		end
        
        it {should_not be_valid}
	end	

    describe "when email format is invalid" do
	    it "should be invalid" do
	      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
	                     foo@bar_baz.com foo@bar+baz.com]
	      addresses.each do |invalid_address|
	        @user.email = invalid_address
	        expect(@user).not_to be_valid
	      end
	    end
    end

	describe "when email format is valid" do
	    it "should be valid" do
	      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
	      addresses.each do |valid_address|
	        @user.email = valid_address
	        expect(@user).to be_valid
	      end
	    end
	end

    describe "when email address is already taken" do
	    before do
	      user_with_same_email = @user.dup
	      user_with_same_email.email = @user.email.upcase
	      user_with_same_email.save
	    end

	    it { should_not be_valid }
    end

  describe "micropost associations" do

    
    before do
    	@user.save 
    	@venue=FactoryGirl.create(:venue)  	
    end


    let!(:older_post) do
      FactoryGirl.create(:post, user: @user, venue: @venue, created_at: 1.day.ago)
    end
    let!(:newer_post) do
      FactoryGirl.create(:post, user: @user, venue:@venue, created_at: 1.hour.ago)
    end

    it "should have the right posts in the right order" do
      expect(@user.posts.to_a).to eq [newer_post, older_post]
    end

    it "should destroy associated microposts" do
      posts = @user.posts.to_a
      @user.destroy
      expect(posts).not_to be_empty
      posts.each do |post|
        expect(Post.where(id: post.id)).to be_empty
      end
    end


  end


end
