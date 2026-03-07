class StatementsController < ApplicationController
  def new
    @statement = Statement.new(date: Date.current)
  end

  def create
    @statement = Statement.new(statement_params)

    if @statement.save
      redirect_to new_statement_path, notice: "明細を保存しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def statement_params
    params.require(:statement).permit(:date, :amount, :summary, :paid_by, :charged_to)
  end
end
