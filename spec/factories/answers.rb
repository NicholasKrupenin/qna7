FactoryBot.define do
  factory :answer do
    question
    user
    body { 'MyAnswerText' }
  end

  trait :invalid do
    body { nil }
  end

  trait :another do
    body { 'Another' }
  end
end
