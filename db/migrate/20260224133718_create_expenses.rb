class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.date :occurred_on, null: false, index: true
      t.integer :payer, null: false
      t.integer :amount, null: false
      t.integer :category, null: false, index: true
      t.string :memo

      t.timestamps
    end

    add_check_constraint :expenses, "amount > 0", name: "amount_positive"
  end
end
