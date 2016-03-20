require "rails_helper"

RSpec.feature "Users can edit their own password" do
  let(:user) { FactoryGirl.create(:user, profile: FactoryGirl.create(:profile)) }

  before do
    login_as(user)
    
    visit user_profile_path(user, user.profile)
    click_link "Settings"
  end

  scenario "with valid attributes" do
    fill_in "Password", with: "newpassword"
    fill_in "Password confirmation", with: "newpassword"
    fill_in "Current password", with: "password"
    
    click_button "Update"

    expect(page.current_url).to eq user_profile_url(user, user.profile)
  end

  scenario "when providing invalid attributes" do
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    fill_in "Current password", with: ""

    click_button "Update"

    expect(page).to have_content "can't be blank"
    expect(page).to have_content "we need your current password to confirm your changes"
  end
end