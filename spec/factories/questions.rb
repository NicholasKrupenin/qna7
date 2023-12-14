FactoryBot.define do
  factory :question do
    title { 'MyString' }
    body { 'MyText' }
    user
    best_answer_id { nil }

    trait :invalid do
      title { nil }
    end

    trait :created_at_yesterday do
      created_at { Date.yesterday }
    end
  end
end
