require 'spec_helper'

describe "vote_records/index" do
  before(:each) do
    assign(:vote_records, [
      stub_model(VoteRecord,
        :user_id => 1,
        :venue_id => 2,
        :is_yes => false
      ),
      stub_model(VoteRecord,
        :user_id => 1,
        :venue_id => 2,
        :is_yes => false
      )
    ])
  end

  it "renders a list of vote_records" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
