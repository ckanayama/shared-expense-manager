class SharedSettlement
  def initialize(expenses)
    @expenses = expenses
  end

  def to_wife
    balance > 0 ? balance : 0
  end

  def to_husband
    balance < 0 ? -balance : 0
  end

  private

    def wife_paid
      @expenses.where(paid_by: :wife, charged_to: :shared).sum(:amount)
    end

    def husband_paid
      @expenses.where(paid_by: :husband, charged_to: :shared).sum(:amount)
    end

    def balance
      (husband_paid - wife_paid) / 2
    end
end
