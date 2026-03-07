class DirectSettlement
  def initialize(statements)
    @statements = statements
  end

  def to_wife
    @statements.where(paid_by: :husband, charged_to: :wife).sum(:amount)
  end

  def to_husband
    @statements.where(paid_by: :wife, charged_to: :husband).sum(:amount)
  end
end
