require "rails_helper"

RSpec.describe SharedSettlement, type: :model do
  subject(:settlement) { SharedSettlement.new(Expense.all) }

  context '妻が共用物の買い物を立て替えた場合' do
    before do
      create(:expense, amount: 1_000, paid_by: :wife, charged_to: :shared)
    end

    it '夫に半額を請求する' do
      expect(settlement.to_husband).to eq 500
    end

    it '妻への精算は発生しない' do
      expect(settlement.to_wife).to eq 0
    end
  end

  context '夫が共用物の買い物を立て替えた場合' do
    before do
      create(:expense, amount: 1_000, paid_by: :husband, charged_to: :shared)
    end

    it '妻に半額を請求する' do
      expect(settlement.to_wife).to eq 500
    end

    it '夫への精算は発生しない' do
      expect(settlement.to_husband).to eq 0
    end
  end
end
