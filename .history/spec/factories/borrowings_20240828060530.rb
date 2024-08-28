FactoryBot.define do
  factory :borrowing do
    association :user
    association :book
    borrowed_at { Faker::Time.backward(days: 14, period: :evening) }
    due_at { Faker::Time.forward(days: 14, period: :evening) }
    returned_at { nil }

    trait :not_returned do
      returned_at { nil }
    end

    trait :not_returned_and_due do
      due_at { Faker::Time.backward(days: 1, period: :evening) }
      returned_at { nil }
    end

    trait :returned do
      returned_at { Faker::Time.backward(days: 7, period: :evening) }
    end
  end
end