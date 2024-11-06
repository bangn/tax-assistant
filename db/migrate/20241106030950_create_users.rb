class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :given_name
      t.string :last_name
      t.string :username
      t.string :email
      t.string :uid

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
    add_index :users, :uid, unique: true
  end
end
