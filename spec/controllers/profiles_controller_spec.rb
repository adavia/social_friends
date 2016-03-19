require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
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

  it "handles owner permission errors by redirecting to a safe place when editing" do
    post :edit, user_id: user_2, id: user_2.profile
    
    expect(response).to redirect_to(user_profile_path(user_2, user_2.profile))
  end

  it "handles owner permission errors by redirecting to a safe place when updating" do
    post :update, user_id: user_2, id: user_2.profile
    
    expect(response).to redirect_to(user_profile_path(user_2, user_2.profile))
  end
end
