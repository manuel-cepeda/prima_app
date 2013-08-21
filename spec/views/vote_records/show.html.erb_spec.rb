require 'spec_helper'

describe "vote_records/show" do
  before(:each) do
    @vote_record = assign(:vote_record, stub_model(VoteRecord,
      :user_id => 1,
      :venue_id => 2,
      :is_yes => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/false/)
  end
end
