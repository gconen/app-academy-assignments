module AuthHelper
  def sign_in_as(user)
    visit "session/new"

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password

    click_button "Sign In"
  end
end
