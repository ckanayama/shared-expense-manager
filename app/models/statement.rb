class Statement < ApplicationRecord
  validates :date, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :paid_by, presence: true
  validates :charged_to, presence: true
  validates :summary, presence: true

  enum :paid_by, {
    shared_account: 0,
    wife: 1,
    husband: 2
  }, prefix: true

  enum :charged_to, {
    shared: 0,
    wife: 1,
    husband: 2
  }, prefix: true
end
