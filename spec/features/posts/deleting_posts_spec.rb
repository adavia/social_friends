require "rails_helper"

RSpec.feature "Users can delete posts" do
  let(:user) { FactoryGirl.create(:user, profile: FactoryGirl.create(:profile)) }
  let!(:post) do
    FactoryGirl.create(:post, user: user)
  end

  before do
    login_as(user)
    visit posts_path
  end

  scenario "successfully", js: true do
    click_link "Remove post"
    
    expect(page).to_not have_content "Example post"
  end
end