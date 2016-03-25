require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:user) { FactoryGirl.create(:user, profile: FactoryGirl.create(:profile)) }
  let(:user_2) do
    FactoryGirl.create(:user, username: "something", email: "something@hotmail.com",
      profile: FactoryGirl.create(:profile, gender: "male",
      birthday: DateTime.now - 3.year,
      location: "Australia"))
  end

  before :each do
    sign_in user
  end

  it "handles owner permission errors by redirecting to a safe place" do
    post :create, user_id: user_2
    
    expect(response).to redirect_to [user_2, user_2.profile]
  end
end
