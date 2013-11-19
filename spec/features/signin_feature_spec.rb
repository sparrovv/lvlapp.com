require 'spec_helper'

feature "Sign In User" do
  background do
    @user = create(:user)
  end

  scenario "When user signs in" do
    visit root_url
    click_link "Log in"

    fill_in "Email", with: @user.email
    fill_in "user_password", with: @user.password
    click_button "Sign in"

    expect(page).to have_button("Log out")
    expect(page).to have_css("body.signed-in")
  end
end
