require "rails_helper"

RSpec.feature "Signed-in users can sign out" do
  let(:user) { FactoryGirl.create(:user, profile: FactoryGirl.create(:profile)) }

  before do
    login_as(user)
  end
  
  scenario do
    visit "/"
    click_link "Sign out"
    expect(page).to have_content "Sign in"
  end
end