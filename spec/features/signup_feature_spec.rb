require 'spec_helper'

feature "Sign Up User" do
  scenario "When user sign ups" do
    visit root_url
    click_link "Log in"
    click_link "Sign up"

    fill_in "Email", with: "test@example.com"
    fill_in "user_password", with: "foobar123"
    fill_in "user_password_confirmation", with: "foobar123"
    select "French", from: 'Your native language'
    click_button "Sign up"

    expect(page).to have_button("Log out")
    expect(page).to have_css("body.signed-in")
  end
end
