require "rails_helper"

RSpec.feature "Users can view attachments" do
  let(:user) { FactoryGirl.create(:user, profile: FactoryGirl.create(:profile)) }
  
  before do
    login_as(user)
    visit user_attachments_path(user)
  end

  scenario "when adding attachments", js: true do
    attach_file "attachments[file][]", Rails.root.join("spec/fixtures/photo1.jpg"), visible: false

    click_button "Submit"

    within("#user-attachments") do
      expect(page).to have_xpath("//img[contains(@src,'photo1.jpg')]")
    end
  end
end