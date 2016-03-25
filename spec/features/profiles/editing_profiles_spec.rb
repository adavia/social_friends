require "rails_helper"

RSpec.feature "Users can edit their own profile" do
  let(:user) { FactoryGirl.create(:user, profile: FactoryGirl.create(:profile)) }

  before do
    login_as(user)
    
    visit user_profile_path(user, :profile)
    click_link "Profile"
  end

  scenario "with valid attributes" do
    select "female", from: "profile_gender"
    select "1975", from: "profile_birthday_1i"
    select "January", from: "profile_birthday_2i"
    select "5", from: "profile_birthday_3i"
    fill_in "Location", with: "Norway"
    
    click_button "Submit"
  end

  scenario "when providing invalid attributes" do
    select "", from: "profile_gender"
    select "1975", from: "profile_birthday_1i"
    select "January", from: "profile_birthday_2i"
    select "5", from: "profile_birthday_3i"
    fill_in "Location", with: ""

    click_button "Submit"

    expect(page).to have_content "can't be blank"
  end

  scenario "with an invalid birthday" do
    select "female", from: "profile_gender"
    select "2016", from: "profile_birthday_1i"
    select "December", from: "profile_birthday_2i"
    select "5", from: "profile_birthday_3i"
    fill_in "Location", with: "Norway"

    click_button "Submit"

    expect(page).to have_content "can't be greater than current date"
  end
end