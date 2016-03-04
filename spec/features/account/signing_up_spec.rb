require "rails_helper"

RSpec.feature "Users can sign up" do
  let!(:user) { FactoryGirl.create(:user) }

  scenario "when providing valid details" do
    visit "/"

    click_link "Sign up"

    fill_in "Email", with: "test@example.com"
    fill_in "user_password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_button "Sign up"
  end
end