require "rails_helper"

RSpec.describe Settlement, type: :model do
  subject(:settlement) { Settlement.new(2026, 3) }

  before do
    create(:statement, amount: 500, paid_by: :wife, charged_to: :husband, date: Date.new(2026, 3, 15))
    create(:statement, amount: 300, paid_by: :husband, charged_to: :shared, date: Date.new(2026, 3, 20))
  end

  describe 'validation' do
    context 'year がない場合' do
      subject(:settlement) { Settlement.new(nil, 3) }

      it 'invalid' do
        expect(settlement).to be_invalid
      end
    end

    context 'month がない場合' do
      subject(:settlement) { Settlement.new(2026, nil) }

      it 'invalid' do
        expect(settlement).to be_invalid
      end
    end

    context 'すべてのパラメータがある場合' do
      it 'valid' do
        expect(settlement).to be_valid
      end
    end
  end

  describe '#direct' do
    it 'DirectSettlementを返す' do
      expect(settlement.direct).to be_a DirectSettlement
    end

    it '対象月の個人間精算を計算する' do
      expect(settlement.direct.to_husband).to eq 500
    end
  end

  describe '#shared' do
    it 'SharedSettlementを返す' do
      expect(settlement.shared).to be_a SharedSettlement
    end

    it '対象月の共有費精算を計算する' do
      expect(settlement.shared.to_wife).to eq 150
    end
  end

  context '対象月外の明細は含まない' do
    before { create(:statement, amount: 1000, paid_by: :wife, charged_to: :husband, date: Date.new(2026, 4, 1)) }

    it '対象月外の明細は精算に含まれない' do
      expect(settlement.direct.to_husband).to eq 500
    end
  end
end
