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

  # 夫が妻（会計管理者）に渡す合計額
  # 正なら夫→妻、負なら妻→夫
  def husband_to_wife_total
    -net_amount + shared_card.to_husband
  end

  # 共有口座への返済合計
  def repay_total
    shared_card.to_wife + shared_card.to_husband
  end

  private
    def statements
      @statements ||= Statement.where(date: Date.new(year, month)..Date.new(year, month, -1))
    end
end
