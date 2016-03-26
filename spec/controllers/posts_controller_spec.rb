require "rails_helper"

RSpec.describe PostsController, type: :controller do
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

  it "handles owner permission errors by redirecting to a safe place when deleting" do
    new_post = FactoryGirl.create(:post, body: "Some cool text here",
      user: user_2)

    get :destroy, id: new_post
    
    expect(response).to redirect_to(posts_path)
  end

  it "handles owner permission errors by redirecting to a safe place when updating" do
    new_post = FactoryGirl.create(:post, body: "Some cool text here",
      user: user_2)

    post :update, id: new_post
    
    expect(response).to redirect_to(posts_path)
  end
end
