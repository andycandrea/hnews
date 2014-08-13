# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body 'this is Major Tom to ground control'
    user

    trait :on_article do
      association :commentable, factory: [:article, :has_url]
    end

    trait :on_comment do
      commentable_type comment
    end
  end
end
