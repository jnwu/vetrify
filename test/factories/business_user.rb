FactoryGirl.define do
  factory :business_user do
    association  			:business, factory: :business
    first_name      		{ Faker::Name.first_name }
    last_name       		{ Faker::Name.last_name }
    email         			{ Faker::Internet.email }
    title         			{ Faker::Job.title }
    password              	'password'
    password_confirmation 	'password'
  end
end
