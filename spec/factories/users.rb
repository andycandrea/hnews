# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'jackiechan'
    email 'abc@efg.co'
    password 'karate'
    password_confirmation 'karate'
  end
end
