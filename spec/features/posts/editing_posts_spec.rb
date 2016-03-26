require "rails_helper"

RSpec.feature "Users can edit their own posts" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:post) { FactoryGirl.create(:post, user: user) }

  before do
    login_as(user)
    
    visit user_profile_path(user)
    click_button "actions"
    click_link "Edit"
  end

  scenario "with valid attributes" do
    fill_in "post_body", with: "This something to edit"
    click_button "Publish"

    expect(page.current_url).to eq posts_url
  end

  scenario "when providing invalid attributes" do
    fill_in "post_body", with: ""
    click_button "Publish"

    expect(page).to have_content "can't be blank"
  end
end