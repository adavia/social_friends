require "rails_helper"

RSpec.describe PostsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_2) { FactoryGirl.create(:user, username: "something", email: "something@hotmail.com") }

  before :each do
    sign_in user
  end

  it "handles owner permission errors by redirecting to a safe place" do
    post = FactoryGirl.create(:post, body: "Some cool text here",
      user: user_2)

    get :destroy, id: post
    
    expect(response).to redirect_to(posts_path)
  end
end
