class CreateReceipts < ActiveRecord::Migration[7.2]
  def change
    create_table :receipts do |t|
      t.string :receipt_number
      t.integer :total_amount, null: false
      t.string :seller
      t.string :note
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :receipts, :receipt_number
    add_index :receipts, :total_amount
    add_index :receipts, :seller
    add_index :receipts, :date
  end
end
