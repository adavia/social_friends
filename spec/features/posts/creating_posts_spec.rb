require "rails_helper"

RSpec.feature "Users can create new posts" do
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user)
    visit posts_path
  end

  scenario "with valid attributes" do
    fill_in "post_body", with: "Saturday pool party event for friends"

    click_button "Publish"

    expect(page).to have_content "Saturday pool party event for friends"
  end

  scenario "when providing invalid attributes" do
    click_button "Publish"

    expect(page).to have_content "can't be blank"
  end

  scenario "with attachments", js: true do
    fill_in "post_body", with: "Saturday pool party event for friends"

    attach_file "attachments[file][]", Rails.root.join("spec/fixtures/photo1.jpg"), visible: false

    click_button "Publish"

    within(".post-content .attachments") do
      expect(page).to have_xpath("//img[contains(@src,'photo1.jpg')]")
    end
  end
end