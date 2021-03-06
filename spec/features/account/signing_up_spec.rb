require "rails_helper"

RSpec.feature "Users can sign up" do
  scenario "when providing valid details" do
    visit "/"

    click_link "Sign up"

    fill_in "Username", with: "example"
    fill_in "Email", with: "test@example.com"
    select 'male', from: "user_profile_attributes_gender"
    select '1989', from: "user_profile_attributes_birthday_1i"
    select 'January', from: "user_profile_attributes_birthday_2i"
    select '5', from: "user_profile_attributes_birthday_3i"
    fill_in "Location", with: "Zimbabwe"
    fill_in "user_password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_button "Sign up"
    
    expect(page).to have_content "Sign out"
  end
end