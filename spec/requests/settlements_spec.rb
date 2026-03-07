require "rails_helper"

RSpec.describe "Settlements", type: :request do
  describe "GET /settlement" do
    it "当月の精算結果を表示する" do
      get settlement_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("#{Date.current.year}年#{Date.current.month}月の精算")
    end

    it "指定月の精算結果を表示する" do
      get settlement_path(year: 2026, month: 2)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("2026年2月の精算")
    end

    it "3種類の内訳と最終精算額を表示する" do
      create(:statement, date: Date.new(2026, 2, 1), paid_by: :husband, charged_to: :wife, amount: 3000)
      create(:statement, date: Date.new(2026, 2, 1), paid_by: :wife, charged_to: :husband, amount: 1000)

      get settlement_path(year: 2026, month: 2)

      expect(response.body).to include("直接精算")
      expect(response.body).to include("共用精算")
      expect(response.body).to include("共用口座精算")
      expect(response.body).to include("最終精算額")
    end
  end
end
