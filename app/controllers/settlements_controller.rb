class SettlementsController < ApplicationController
  def show
    year = (params[:year] || Date.current.year).to_i
    month = (params[:month] || Date.current.month).to_i
    @settlement = Settlement.new(year, month)
  end
end
