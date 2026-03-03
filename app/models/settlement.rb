class Settlement
  validates :start_datetime, presence: true
  validates :end_datetime, presence: true

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
    @expenses = Expense.where(occurred_on: start_datetime..end_datetime)
  end

  def direct
    DirectSettlement.new(@expenses)
  end

  def shared
    SharedSettlement.new(@expenses)
  end
end
