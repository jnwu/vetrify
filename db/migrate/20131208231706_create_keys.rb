class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.string :api, null: false
      t.string :tag, null: false
      t.string :key

      t.timestamps
    end
    add_index :keys, :key, unique: true
  end
end
