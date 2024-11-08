class ChangeReceiptNumberToDescription < ActiveRecord::Migration[8.0]
  def change
    rename_column :receipts, :receipt_number, :description
  end
end
