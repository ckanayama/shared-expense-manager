class Expense < ApplicationRecord
  validates :occurred_on, presence: true
  validates :payer, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :category, presence: true
end
