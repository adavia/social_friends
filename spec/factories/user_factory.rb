FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "test#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password "password"
  end
end