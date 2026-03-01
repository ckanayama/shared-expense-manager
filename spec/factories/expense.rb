FactoryBot.define do
  factory :expense do
    amount { 1_000 }
    paid_by { :wife }
    charged_to { :husband }
    occurred_on { Time.zone.now }
  end
end
