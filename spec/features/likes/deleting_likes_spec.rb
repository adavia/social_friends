require "rails_helper"

RSpec.feature "Users can delete an existing like" do
  let(:user) { FactoryGirl.create(:user, profile: FactoryGirl.create(:profile)) }
  let!(:attachment) { FactoryGirl.create(:attachment,
    attachable_id: user.id, attachable_type: "User") }

  before do
    login_as(user)
    visit user_attachment_path(user, attachment)
    click_link "Like"
  end

  scenario "when clicking the unlike link" do
    click_link "Unlike"

    expect(page).to have_content "0"
  end
end