class AddReceiptsCategory < ActiveRecord::Migration[8.0]
  def up
    create_enum :category, %w[income deduction]
    change_table :receipts do |t|
      t.enum :category, enum_type: "category", default: "deduction", null: false
    end
  end

  def down
    remove_column :receipts, :category
    execute <<-SQL
      DROP TYPE category
    SQL
  end
end
