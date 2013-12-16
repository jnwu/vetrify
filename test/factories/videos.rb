FactoryGirl.define do
  factory :video do
    association       :applicant, factory: :applicant
    pandastream_id    { Faker::Company.bs }
    url               { Faker::Internet.domain_name }
  end
end
