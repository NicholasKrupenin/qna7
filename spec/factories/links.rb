FactoryBot.define do
  factory :link do
    name { "Link name" }
    url { 'https://www.google.com/' }
  end

  trait :gist do
    url { 'https://gist.github.com/NicholasKrupenin/0aad932f40c9a1b69e203907f37e652f' }
  end

  trait :assoc_answer do
    association :linkable, factory: :answer
  end

  trait :assoc_question do
    association :linkable, factory: :question
  end
end
