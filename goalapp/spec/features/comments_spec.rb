require 'spec_helper'
require 'rails_helper'
include AuthHelper
include GoalsHelper

feature "comments" do
  before(:each) do
    @user = create :user
  end

  it "creates comments on users" do
    sign_in_as(@user)
    click_link "comment-user"

    fill_in "body", with: "this is a comment"
    click_button "Create Comment"

    expect(page).to have_content("this is a comment")
  end

  it "creates comments on goal" do
    create_goal_for(user: @user)

    click_link "comment-goal"

    fill_in "body", with: "this is a comment"
    click_button "Create Comment"

    expect(page).to have_content("this is a comment")
  end

end
