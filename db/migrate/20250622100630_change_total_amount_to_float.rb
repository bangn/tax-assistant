class ChangeTotalAmountToFloat < ActiveRecord::Migration[8.0]
  def change
    change_column :receipts, :total_amount, :float
  end
end
