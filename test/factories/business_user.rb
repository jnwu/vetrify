FactoryGirl.define do
  factory :business_user do
    association   :business, factory: :business
    name          { Faker::Company.name }
    email         { Faker::Internet.email }
    title         { Faker::Company.bs }
    password              'm-e-t-h-o-d'
    password_confirmation 'm-e-t-h-o-d'
  end
end
