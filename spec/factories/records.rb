FactoryBot.define do
  factory :record do
    user
    started_at { "2017-09-25 14:40:47" }
    finished_at { "2017-09-25 14:40:47" }

    trait :without_user do
      user { nil }
    end
  end
end
