FactoryBot.define do
  factory :borrowing do
    user { nil }
    book { nil }
    borrowed_at { "2024-08-27 18:11:19" }
    due_at { "2024-08-27 18:11:19" }
    returned { false }
  end
end
