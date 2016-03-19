require "rails_helper"

RSpec.feature "Users can view user profiles" do
  let(:user) { FactoryGirl.create(:user, profile: FactoryGirl.create(:profile)) }
  
  before do
    login_as(user)
    visit user_profile_path(user, user.profile)
  end

  scenario "with user details" do
    expect(page).to have_content "Joined in #{user.created_at.strftime('%B %Y')}"
  end
end