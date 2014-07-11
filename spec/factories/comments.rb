# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body 'this is Major Tom to ground control'
    user

    trait :on_article do
      commentable_type article
    end

    trait :on_comment do
      commentable_type comment
    end
  end
end
