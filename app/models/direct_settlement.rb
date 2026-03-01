class DirectSettlement
  def initialize(expenses)
    @expenses = expenses
  end

  def to_wife
    @expenses.where(paid_by: :husband, charged_to: :wife).sum(:amount)
  end

  def to_husband
    @expenses.where(paid_by: :wife, charged_to: :husband).sum(:amount)
  end
end
