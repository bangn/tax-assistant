class AddTrigramIndexToReceipts < ActiveRecord::Migration[8.0]
  def change
    add_index :receipts, :seller, using: :gin, opclass: :gist_trgm_ops
    add_index :receipts, :description, using: :gin, opclass: :gist_trgm_ops
    add_index :receipts, :note, using: :gin, opclass: :gist_trgm_ops
  end
end
