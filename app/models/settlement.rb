class Settlement
  include ActiveModel::Model

  attr_reader :year, :month

  validates :year, presence: true
  validates :month, presence: true

  def initialize(year, month)
    @year = year
    @month = month
  end

  def direct
    DirectSettlement.new(statements)
  end

  def shared
    SharedSettlement.new(statements)
  end

  def shared_card
    SharedAccountSettlement.new(statements)
  end

  def net_amount
    to_wife = direct.to_wife + shared.to_wife
    to_husband = direct.to_husband + shared.to_husband
    to_wife - to_husband
  end

  private
    def statements
      @statements ||= Statement.where(date: Date.new(year, month)..Date.new(year, month, -1))
    end
end
