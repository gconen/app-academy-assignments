require 'spec_helper'
require 'rails_helper'
# require 'support/auth_helper'

include AuthHelper

feature "the signup process" do
  it "has a new user page" do
    visit "users/new"

    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do

    it "shows user name on the homepage after signup" do
      visit "users/new"

      fill_in "Username", with: "Bobby"
      fill_in "Password", with: "Password"

      click_button "Sign Up"

      expect(page).to have_content "Bobby"
    end

    it "shows errors for invalid signup" do
      visit "users/new"
      click_button "Sign Up"
      expect(page).to have_content "Username can't be blank"
      expect(page).to have_content "Password is too short"
    end
  end
end

feature "logging in" do
  it "shows username on the homepage after login" do
    user = create :user
    sign_in_as(user)

    expect(page).to have_content "Bobby"
  end

  it "shows errors for invalid sign in" do
    user = create :user
    visit new_session_url
    click_button "Sign In"
    expect(page).to have_content "invalid password user combination"
  end
end

feature "logging out" do
  it "begins with logged out state" do
    visit "users"

    expect(current_path).to eql('/session/new')
  end

  it "doesn't show username on homepage after logout" do
    user = create :user
    sign_in_as(user)

    click_button "Log Out"

    expect(page).to_not have_content "Bobby"
  end

end
