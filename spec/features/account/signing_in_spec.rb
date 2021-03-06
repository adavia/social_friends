require "rails_helper"

RSpec.feature "Users can sign in" do
  let(:user) { FactoryGirl.create(:user, profile: FactoryGirl.create(:profile)) }

  scenario "when providing valid details" do
    visit "/"

    click_link "Sign in"

    fill_in "Email", with: user.email
    fill_in "Password", with: "password"

    click_button "Sign in"

    expect(page).to have_content "Signed in as #{user}"
  end
end