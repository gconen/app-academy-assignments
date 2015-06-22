require 'spec_helper'
require 'rails_helper'
include AuthHelper
include GoalsHelper

feature "goals" do
  before(:each) do
    @user = create :user
    create_goal_for(user: @user)
  end

  it "has a link to make a new goal" do
    visit(user_url(@user))
    click_link("New Goal")

    expect(page).to have_content("Create New Goal")
  end

  it "makes a new goal" do
    expect(page).to have_content(@user.username)
    expect(page).to have_content("Test Goal")
  end

  it "completes goals" do
    visit(user_url(@user))

    expect(page).to_not have_content("Completed")

    click_button "Complete Goal"

    expect(page).to have_content("Completed")
  end

  it "hides private goals and shows public goals" do
    other_user = create(:user, username: "Carol")
    create_goal_for(user: @user, privacy: true, name: "Private Goal")

    visit(user_url(@user))
    expect(page).to have_content("Test Goal")
    expect(page).to have_content("Private Goal")

    click_button "Log Out"
    sign_in_as(other_user)

    visit(user_url(@user))
    expect(page).to have_content("Test Goal")
    expect(page).to_not have_content("Private Goal")
  end

  it "updates goals" do
    click_link "Edit Goal"

    fill_in "Name", with: "Editted Goal"
    click_button "Update Goal"

    expect(page).to have_content("Editted Goal")
  end

  it "deletes goals" do
    click_button "Cancel Goal"

    expect(page).to_not have_content("Test Goal")
  end
end

describe "users can find other users" do
  before(:each) do
    @user = create :user
    sign_in_as(@user)
  end

  it "has an index" do
    visit('/users')

    expect(page).to have_content("Bobby")
  end
end
