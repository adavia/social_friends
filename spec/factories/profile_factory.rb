FactoryGirl.define do
  factory :profile do
    gender "male"
    birthday DateTime.now - 2.year
    location "Cordoba"
  end
end