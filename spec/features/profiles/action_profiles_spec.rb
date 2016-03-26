require "rails_helper"

RSpec.feature "Users can interact with other users" do
  let(:user) { FactoryGirl.create(:user, profile: FactoryGirl.create(:profile)) }
  let(:user_2) do
    FactoryGirl.create(:user, username: "something", email: "something@hotmail.com",
      profile: FactoryGirl.create(:profile, gender: "male",
      birthday: DateTime.now - 3.year,
      location: "Australia"))
  end
  
  before do
    login_as(user)
    visit user_profile_path(user_2, :profile)
  end

  scenario "when they follow a user" do
    click_button "Follow"
    expect(page).to have_content "Followers 1"
  end

  scenario "when they unfollow a user" do
    click_button "Follow"
    click_button "Unfollow"
    expect(page).to have_content "Followers 0"
  end
end