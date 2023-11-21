FactoryBot.define do
  factory :vote do
    user
  end

  factory :vote_answer do
    user
    association :voteable, factory: :answer
  end

  factory :vote_question do
    user
    association :voteable, factory: :question
  end
end
