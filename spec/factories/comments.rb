# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body 'this is Major Tom to ground control'
  
    trait :on_article do
      commentable_type 'Article'
    end

    trait :on_comment do
      commentable_type 'Comment'
    end
  end
end
