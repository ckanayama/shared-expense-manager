require "rails_helper"

RSpec.describe "Statements", type: :request do
  let(:payee) { create(:payee) }
  let(:valid_params) do
    {
      statement: {
        date: "2026-02-15",
        amount: 1500,
        description: "食品",
        payee_id: payee.id,
        paid_by: "wife",
        charged_to: "husband"
      }
    }
  end

  describe "GET /statements" do
    it "対象月の明細を表示する" do
      create(:statement, date: Date.new(2026, 2, 10))
      create(:statement, date: Date.new(2026, 3, 1))

      get statements_path(year: 2026, month: 2)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("2026年2月の明細")
    end

    it "年月未指定の場合は当月を表示する" do
      get statements_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("#{Date.current.year}年#{Date.current.month}月の明細")
    end
  end

  describe "GET /statements/new" do
    it "入力フォームを表示する" do
      get new_statement_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("明細入力")
    end

    it "最近の明細を表示する" do
      statement = create(:statement, description: "テスト明細")

      get new_statement_path

      expect(response.body).to include("テスト明細")
    end
  end

  describe "POST /statements" do
    it "明細を作成してリダイレクトする" do
      expect {
        post statements_path, params: valid_params
      }.to change(Statement, :count).by(1)

      expect(response).to redirect_to(new_statement_path)

      statement = Statement.last
      expect(statement.description).to eq("食品")
      expect(statement.payee).to eq(payee)
      expect(statement.amount).to eq(1500)
    end

    it "バリデーションエラー時はフォームを再表示する" do
      post statements_path, params: { statement: { amount: 0 } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /statements/:id/edit" do
    it "編集フォームを表示する" do
      statement = create(:statement)

      get edit_statement_path(statement)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("明細編集")
    end
  end

  describe "PATCH /statements/:id" do
    it "明細を更新してリダイレクトする" do
      statement = create(:statement, date: Date.new(2026, 2, 1), description: "旧摘要")

      patch statement_path(statement), params: { statement: { description: "新摘要", payee_id: payee.id } }

      expect(response).to redirect_to(statements_path(year: 2026, month: 2))
      expect(statement.reload.description).to eq("新摘要")
      expect(statement.payee).to eq(payee)
    end

    it "バリデーションエラー時は編集フォームを再表示する" do
      statement = create(:statement)

      patch statement_path(statement), params: { statement: { amount: 0 } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /statements/:id" do
    it "明細を削除してリダイレクトする" do
      statement = create(:statement, date: Date.new(2026, 2, 1))

      expect {
        delete statement_path(statement)
      }.to change(Statement, :count).by(-1)

      expect(response).to redirect_to(statements_path(year: 2026, month: 2))
    end
  end
end
