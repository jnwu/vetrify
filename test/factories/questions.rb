FactoryGirl.define do
  factory :question do
    association       :post, factory: :post
    description       { Faker::Lorem.paragraph(1) }
  end
end
