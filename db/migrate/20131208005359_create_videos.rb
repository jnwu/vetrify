class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.belongs_to :applicant, index: true
      t.string :pandastream_id, null: false
      t.string :url, null: false

      t.timestamps
    end
    add_index :videos, :pandastream_id, unique: true
    add_index :videos, :url, unique: true
  end
end
