FactoryGirl.define do
  factory :article do
    title 'Such title'
    user

    trait :has_url do
      url 'www.much.url/wow.html'
    end
    
    trait :has_content do
      content 'Very content.'
    end
  end
end
