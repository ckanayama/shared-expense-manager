class Expense < ApplicationRecord
  validates :occurred_on, presence: true
  validates :payer, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :category, presence: true

  enum :payer, { partner_a: 0, partner_b: 1 }
  enum :category, { shared: 0, personal_transfer: 1 }
end
