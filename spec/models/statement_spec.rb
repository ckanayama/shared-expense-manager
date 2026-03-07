require "rails_helper"

RSpec.describe Statement, type: :model do
  describe 'amount_positive' do
    let(:statement) { build(:statement, amount:) }

    context 'amount is positive' do
      let(:amount) { 100 }

      it 'be valid' do
        expect(statement).to be_valid
      end
    end

    context 'amount is zero' do
      let(:amount) { 0 }

      it 'be valid' do
        expect(statement).to be_invalid
      end
    end

    context 'amount is negative' do
      let(:amount) { -100 }

      it 'not be valid' do
        expect(statement).to be_invalid
      end
    end
  end

  describe '支払者と負担者の同一チェック' do
    context '支払者と負担者が同一の場合' do
      it 'invalid' do
        statement = build(:statement, paid_by: :wife, charged_to: :wife)
        expect(statement).to be_invalid
      end
    end

    context '支払者と負担者が異なる場合' do
      it 'valid' do
        statement = build(:statement, paid_by: :wife, charged_to: :husband)
        expect(statement).to be_valid
      end
    end
  end
end
