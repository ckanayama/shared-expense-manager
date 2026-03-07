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

  private
    def statements
      @statements ||= Statement.where(date: Date.new(year, month)..Date.new(year, month, -1))
    end
end
