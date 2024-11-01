class SecretGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :secret_groups, id: false, primary_key: [:name, :owner] do |t|
      t.string :name, null: false
      t.string :owner, null: false
      t.text :description

      t.timestamps
    end

    add_index :secret_groups, [:name, :owner], unique: true
    add_foreign_key :secret_groups, :users, column: :owner, primary_key: :name, on_update: :cascade, on_delete: :cascade
    add_foreign_key :secrets, :secret_groups, column: [:group_name, :owner], primary_key: [:name, :owner], on_update: :cascade, on_delete: :cascade
  end
end
