FactoryGirl.define do
  factory :post do
    association       :business, factory: :business
    position          { Faker::Name.name }
    summary           { Faker::Lorem.paragraph(3) }
    desired_skills    ["Html", "Css"]
    expected_skills   ["Ruby", "Rails", "Coffee"]
    start_at          DateTime.now
    expire_at         DateTime.now + 2.weeks
  end
end


# one:
#   company_id:
#   position: MyString
#   summary: MyText
#   desired_skills: MyText
#   expected_skills: MyText
#   start_at: 2013-12-07
#   expire_at: 2013-12-07 17:04:29
