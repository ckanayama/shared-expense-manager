class StatementsController < ApplicationController
  def index
    year = (params[:year] || Date.current.year).to_i
    month = (params[:month] || Date.current.month).to_i
    @year = year
    @month = month
    @statements = Statement.where(date: Date.new(year, month)..Date.new(year, month, -1)).order(:date)
  end

  def new
    @statement = Statement.new(date: Date.current)
    @recent_statements = Statement.order(date: :desc).limit(5)
  end

  def create
    @statement = Statement.new(statement_params)

    if @statement.save
      redirect_to new_statement_path, notice: "明細を保存しました"
    else
      @recent_statements = Statement.order(date: :desc).limit(5)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @statement = Statement.find(params[:id])
  end

  def update
    @statement = Statement.find(params[:id])

    if @statement.update(statement_params)
      redirect_to statements_path(year: @statement.date.year, month: @statement.date.month), notice: "明細を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @statement = Statement.find(params[:id])
    year = @statement.date.year
    month = @statement.date.month
    @statement.destroy
    redirect_to statements_path(year: year, month: month), notice: "明細を削除しました"
  end

  private

  def statement_params
    params.require(:statement).permit(:date, :amount, :summary, :paid_by, :charged_to)
  end
end
