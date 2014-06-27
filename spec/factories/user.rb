# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "jackiechan#{n}" }
    sequence(:email) { |n| "jcclone#{n}@example.com" }
    password 'karate'
    password_confirmation 'karate'
  end
end
