require "rails_helper"

describe "the user sign-up path" do
  it "allows a user to sign up with a username, email, and password" do
    visit '/sign_up'
    fill_in "Name", with: "New User"
    fill_in "Email", with: "user@email.com"
    fill_in "Password", with: "test1234"
    fill_in "Password confirmation", with: "test1234"
    click_button "new_user_button"
    expect(page).to have_content("New User's Cart")
  end

end
