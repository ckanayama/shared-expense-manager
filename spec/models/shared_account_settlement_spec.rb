require "rails_helper"

RSpec.describe SharedAccountSettlement, type: :model do
  subject(:settlement) { SharedAccountSettlement.new(Expense.all) }

  context '妻が共用費で私物を購入した場合' do
    before do
      create(:expense, amount: 500, paid_by: :shared_account, charged_to: :wife)
    end

    it '妻に全額を請求する' do
      expect(settlement.to_wife).to eq 500
    end

    it '夫への精算は発生しない' do
      expect(settlement.to_husband).to eq 0
    end
  end

  context '夫が共用費で私物を購入した場合' do
    before do
      create(:expense, amount: 500, paid_by: :shared_account, charged_to: :husband)
    end

    it '夫に全額を請求する' do
      expect(settlement.to_husband).to eq 500
    end

    it '妻への精算は発生しない' do
      expect(settlement.to_wife).to eq 0
    end
  end
end
