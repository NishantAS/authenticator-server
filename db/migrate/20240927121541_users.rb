class Users < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: false do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.boolean :verified, default: false, null: false
      t.string :default_group_name, default: "All", null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :name, unique: true
  end
end
