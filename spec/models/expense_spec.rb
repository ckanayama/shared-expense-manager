require "rails_helper"

RSpec.describe Expense, type: :model do
  describe 'amount_positive' do
    let(:expense) { FactoryBot.build(:expense, amount:) }

    context 'amount is positive' do
      let(:amount) { 100 }

      it 'be valid' do
        expect(expense).to be_valid
      end
    end

    context 'amount is positive' do
      let(:amount) { 0 }

      it 'be valid' do
        expect(expense).to be_invalid
      end
    end

    context 'amount is negative' do
      let(:amount) { -100 }

      it 'not be valid' do
        expect(expense).to be_invalid
      end
    end
  end
end
