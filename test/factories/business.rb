FactoryGirl.define do
  factory :business do
    name          { Faker::Company.name }
    company_type  "Technology"
    status        { Faker::Company.bs }
    location      { Faker::Address.city }
    size          1
    founded_year  1991
    specialties   { Faker::Company.bs }
    domain        { Faker::Internet.domain_name }
    url           { Faker::Internet.domain_name }
    linkedin      { Faker::Internet.domain_name }
  end
end
