FactoryBot.define do
  factory :statement do
    amount { 1_000 }
    paid_by { :wife }
    charged_to { :husband }
    date { Time.zone.today }
    description { "テスト" }
    payee
  end
end
