require 'spec_helper'

describe "User pages"do

  subject { page }

	describe "profile page" do
	  
		let(:user) { FactoryGirl.create(:user)}

		before { visit user_path(user) }

		it { should have_title(user.name) }

	end

end