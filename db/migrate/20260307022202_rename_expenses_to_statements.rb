class RenameExpensesToStatements < ActiveRecord::Migration[8.1]
  def change
    rename_table :expenses, :statements
    rename_column :statements, :occurred_on, :date
    rename_column :statements, :memo, :summary
    change_column_null :statements, :summary, false, ""
    add_check_constraint :statements, "paid_by != charged_to", name: "paid_by_not_equal_to_charged_to"
  end
end
