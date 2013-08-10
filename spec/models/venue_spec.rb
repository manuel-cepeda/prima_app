require 'spec_helper'

describe Venue do
  before { @venue = Venue.new(title: "First Venue", body: "Body Text")}

  subject { @venue }

  it {should respond_to(:title)}
  it {should respond_to(:body)}
  it {should be_valid}

  describe "When title is not present" do
  	before do
  	  @venue.title = " "
  	end
  	it {should_not be_valid}
  end

  describe "when title is too long" do
  	before { @venue.title="a"*61 }
  	it {should_not be_valid}
  end

end