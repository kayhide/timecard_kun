FactoryBot.define do
  factory :user do
    sequence(:name) { |i| "User #{i}" }
  end

  trait :with_user do
    user
  end
end
