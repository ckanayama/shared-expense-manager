class CreateConfirmedSettlements < ActiveRecord::Migration[8.1]
  def change
    create_table :confirmed_settlements do |t|
      t.integer :year, null: false
      t.integer :month, null: false

      t.timestamps
    end

    add_index :confirmed_settlements, [ :year, :month ], unique: true
  end
end
