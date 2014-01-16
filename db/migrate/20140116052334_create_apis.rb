class CreateApis < ActiveRecord::Migration
  def change
    create_table :apis do |t|
      t.string :provider
      t.string :tag
      t.string :key

      t.timestamps
    end
    add_index :apis, :key, unique: true
  end
end
