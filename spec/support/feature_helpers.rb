module FeatureHelpers
  def sign_in(user)
    visit root_url
    click_link "Log in"

    fill_in "Email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Sign in"
  end
end
