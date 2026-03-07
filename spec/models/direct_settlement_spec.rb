require "rails_helper"

RSpec.describe DirectSettlement, type: :model do
  subject(:settlement) { DirectSettlement.new(Statement.all) }

  context '妻が夫の買い物を代行した場合' do
    before { create(:statement, amount: 300, paid_by: :wife, charged_to: :husband) }

    it '夫への請求額は300円' do
      expect(settlement.to_husband).to eq 300
    end

    it '妻への請求額は0円' do
      expect(settlement.to_wife).to eq 0
    end
  end

  context '夫が妻の買い物を代行した場合' do
    before { create(:statement, amount: 300, paid_by: :husband, charged_to: :wife) }

    it '夫への請求額は0円' do
      expect(settlement.to_husband).to eq 0
    end

    it '妻への請求額は300円' do
      expect(settlement.to_wife).to eq 300
    end
  end

  context 'お互いに買い物を代行した場合' do
    before do
      create(:statement, amount: 500, paid_by: :wife, charged_to: :husband)
      create(:statement, amount: 300, paid_by: :husband, charged_to: :wife)
    end

    it '夫への請求額は500円' do
      expect(settlement.to_husband).to eq 500
    end

    it '妻への請求額は300円' do
      expect(settlement.to_wife).to eq 300
    end
  end
end
