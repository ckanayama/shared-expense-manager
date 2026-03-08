class ConfirmedSettlement < ApplicationRecord
  validates :year, presence: true
  validates :month, presence: true
  validates :year, uniqueness: { scope: :month }

  def self.confirmed?(year, month)
    exists?(year: year, month: month)
  end
end
