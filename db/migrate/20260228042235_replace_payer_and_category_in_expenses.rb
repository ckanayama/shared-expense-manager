class ReplacePayerAndCategoryInExpenses < ActiveRecord::Migration[8.1]
  def change
    remove_column :expenses, :payer, :integer
    remove_column :expenses, :category, :integer

    add_column :expenses, :paid_by, :integer, null: false
    add_column :expenses, :charged_to, :integer, null: false

    add_index :expenses, :paid_by
    add_index :expenses, :charged_to
  end
end
