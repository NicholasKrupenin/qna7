FactoryBot.define do
  factory :regard do
    question
    name { 'Your reward' }

    after(:build) do |model_instance|
      model_instance.pic.attach(
        io: File.open(Rails.root.join('app/assets/images/space.jpg')),
        filename: 'space.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
