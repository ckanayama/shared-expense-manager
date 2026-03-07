class SharedAccountSettlement
  def initialize(statements)
    @statements = statements
  end

  def to_wife
    @statements.where(paid_by: :shared_account, charged_to: :wife).sum(:amount)
  end

  def to_husband
    @statements.where(paid_by: :shared_account, charged_to: :husband).sum(:amount)
  end
end
