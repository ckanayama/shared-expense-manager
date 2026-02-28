class Expense < ApplicationRecord
  validates :occurred_on, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :paid_by, presence: true
  validates :charged_to, presence: true

  enum :paid_by, {
    shared_account: 0,
    wife: 1,
    husband: 2
  }

  enum :charged_to, {
    shared: 0,
    wife: 1,
    husband: 2
  }
end
