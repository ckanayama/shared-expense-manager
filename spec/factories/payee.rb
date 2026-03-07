FactoryBot.define do
  factory :payee do
    sequence(:name) { |n| "店舗#{n}" }
  end
end
