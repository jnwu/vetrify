class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :source_type, null: false
      t.string :intent, null: false
      t.string :origin, null: false
      t.date :started_at, null: false
      t.date :ended_at, null: false
      t.text :summary
      t.string :url

      t.timestamps
    end
  end
end
