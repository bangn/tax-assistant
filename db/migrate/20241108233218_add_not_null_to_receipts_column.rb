class AddNotNullToReceiptsColumn < ActiveRecord::Migration[8.0]
  def change
    change_column_null :receipts, :description, false
    change_column_null :receipts, :seller, false
    change_column_null :receipts, :date, false
  end
end
