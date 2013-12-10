FactoryGirl.define do
  factory :post do
    association       :business, factory: :business
    position          { Faker::Name.name }
    summary           { Faker::Lorem.paragraph(3) }
    desired_skills    "Html"
    expected_skills   "Ruby"
    start_at          DateTime.now
    expire_at         DateTime.now + 2.weeks
  end
end
