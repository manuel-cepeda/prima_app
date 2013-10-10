require 'spec_helper'

describe "feedbacks/edit" do
  before(:each) do
    @feedback = assign(:feedback, stub_model(Feedback,
      :user_id => 1,
      :description => "MyText"
    ))
  end

  it "renders the edit feedback form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", feedback_path(@feedback), "post" do
      assert_select "input#feedback_user_id[name=?]", "feedback[user_id]"
      assert_select "textarea#feedback_description[name=?]", "feedback[description]"
    end
  end
end
