class Settlement
  include ActiveModel::Model

  attr_reader :start_at, :end_at

  validates :start_at, presence: true
  validates :end_at, presence: true

  def initialize(start_at, end_at)
    @start_at = start_at
    @end_at = end_at
    @expenses = Expense.where(occurred_on: start_at..end_at)
  end

  def direct
    DirectSettlement.new(@expenses)
  end

  def shared
    SharedSettlement.new(@expenses)
  end

  def shared_card
    SharedAccountSettlement.new(@expenses)
  end
end
