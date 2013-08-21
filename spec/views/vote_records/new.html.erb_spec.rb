require 'spec_helper'

describe "vote_records/new" do
  before(:each) do
    assign(:vote_record, stub_model(VoteRecord,
      :user_id => 1,
      :venue_id => 1,
      :is_yes => false
    ).as_new_record)
  end

  it "renders new vote_record form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", vote_records_path, "post" do
      assert_select "input#vote_record_user_id[name=?]", "vote_record[user_id]"
      assert_select "input#vote_record_venue_id[name=?]", "vote_record[venue_id]"
      assert_select "input#vote_record_is_yes[name=?]", "vote_record[is_yes]"
    end
  end
end
