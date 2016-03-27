require "rails_helper"

RSpec.feature "Users can add a new like" do
  let(:user) { FactoryGirl.create(:user, profile: FactoryGirl.create(:profile)) }
  let!(:attachment) { FactoryGirl.create(:attachment,
    attachable_id: user.id, attachable_type: "User") }

  before do
    login_as(user)
    visit user_attachment_path(user, attachment)
  end

  scenario "when clicking the like link" do
    click_link "Like"

    expect(page).to have_content "1"
  end
end