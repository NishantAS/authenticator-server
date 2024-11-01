class Secrets < ActiveRecord::Migration[7.1]
  def change
    create_table :secrets do |t|
      t.string :name
      t.text :description
      t.string :value, null: false
      t.bigint :interval, default: 30000000, null: false
      t.boolean :is_google, default: false, null: false
      t.integer :length, default: 6, null: false
      t.string :group_name, null: false
      t.string :owner, null: false

      t.timestamps
    end
    add_index :secrets, [:group_name, :owner]
  end
end
