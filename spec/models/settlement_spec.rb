require "rails_helper"

RSpec.describe Settlement, type: :model do
  subject(:settlement) { Settlement.new(start_at, end_at) }
  let(:start_at) { Date.new(2026, 3, 1) }
  let(:end_at) { Date.new(2026, 3, 31) }

  before do
    create(:expense, amount: 500, paid_by: :wife, charged_to: :husband, occurred_on: Date.new(2026, 3, 15))
    create(:expense, amount: 300, paid_by: :husband, charged_to: :shared, occurred_on: Date.new(2026, 3, 20))
  end

  describe 'validation' do
    context 'start_at がない場合' do
      let(:start_at) { nil }

      it 'invalid' do
        expect(settlement).to be_invalid
      end
    end

    context 'end_at がない場合' do
      let(:end_at) { nil }

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

    it '期間内の個人間精算を計算する' do
      expect(settlement.direct.to_husband).to eq 500
    end
  end

  describe '#shared' do
    it 'SharedSettlementを返す' do
      expect(settlement.shared).to be_a SharedSettlement
    end

    it '期間内の共有費精算を計算する' do
      expect(settlement.shared.to_wife).to eq 150
    end
  end

  context '期間外の経費は含まない' do
    before { create(:expense, amount: 1000, paid_by: :wife, charged_to: :husband, occurred_on: Date.new(2026, 4, 1)) }

    it '期間外の経費は精算に含まれない' do
      expect(settlement.direct.to_husband).to eq 500
    end
  end
end
