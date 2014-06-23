FactoryGirl.define do
  factory :article do
    title "Such title"

    trait :has_url do
      url "www.much.url"
    end
    
    trait :has_content do
      content "Very content."
    end
  end
end
