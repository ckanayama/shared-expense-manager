class StatementsController < ApplicationController
  def index
    year = (params[:year] || Date.current.year).to_i
    month = (params[:month] || Date.current.month).to_i
    @year = year
    @month = month
    @statements = Statement.includes(:payee).where(date: Date.new(year, month)..Date.new(year, month, -1)).order(:date)
  end

  def new
    @statement = Statement.new(date: Date.current)
    @recent_statements = Statement.includes(:payee).order(created_at: :desc).limit(5)
    check_confirmed_month(@statement.date)
  end

  def create
    @statement = Statement.new(statement_params)

    if @statement.save
      flash_confirmed_month_warning(@statement.date)
      redirect_to new_statement_path, notice: "明細を保存しました"
    else
      @recent_statements = Statement.includes(:payee).order(created_at: :desc).limit(5)
      check_confirmed_month(@statement.date)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @statement = Statement.find(params[:id])
    check_confirmed_month(@statement.date)
  end

  def update
    @statement = Statement.find(params[:id])

    if @statement.update(statement_params)
      flash_confirmed_month_warning(@statement.date)
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
    params.require(:statement).permit(:date, :amount, :description, :payee_id, :paid_by, :charged_to)
  end

  def confirmed_month_message(date)
    "#{date.year}年#{date.month}月の精算は確定済みです。明細を変更すると精算結果が変わります。" if date && ConfirmedSettlement.confirmed?(date.year, date.month)
  end

  def check_confirmed_month(date)
    @confirmed_month_warning = confirmed_month_message(date)
  end

  def flash_confirmed_month_warning(date)
    message = confirmed_month_message(date)
    flash[:warning] = message if message
  end
end
