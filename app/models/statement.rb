class Statement < ApplicationRecord
  validates :date, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :paid_by, presence: true
  validates :charged_to, presence: true
  validates :description, presence: true

  belongs_to :payee, optional: true
  validate :paid_by_and_charged_to_must_differ

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

  private

  def paid_by_and_charged_to_must_differ
    if paid_by_before_type_cast == charged_to_before_type_cast
      errors.add(:base, "支払者と負担者が同一です")
    end
  end
end
