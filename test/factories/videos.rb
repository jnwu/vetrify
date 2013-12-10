FactoryGirl.define do
  factory :video do
    association       :profile, factory: :profile
    pandastream_id    "MyPandaId"
    url               { Faker::Internet.domain_name }
  end
end
