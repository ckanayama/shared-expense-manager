class SettlementConfirmationsController < ApplicationController
  def create
    year = params[:year].to_i
    month = params[:month].to_i
    ConfirmedSettlement.find_or_create_by!(year: year, month: month)
    redirect_to settlement_path(year: year, month: month), notice: "#{year}年#{month}月の精算を確定しました"
  end


end
