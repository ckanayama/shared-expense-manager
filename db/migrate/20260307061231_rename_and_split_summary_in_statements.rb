class RenameAndSplitSummaryInStatements < ActiveRecord::Migration[8.1]
  def change
    create_table :payees do |t|
      t.string :name, null: false
      t.timestamps
    end

    rename_column :statements, :summary, :description
    add_reference :statements, :payee, foreign_key: true
  end
end
