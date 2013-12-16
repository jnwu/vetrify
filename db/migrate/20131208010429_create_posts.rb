class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :business, index: true
      t.string :position, null: false
      t.text :summary, null: false
      t.text :desired_skills
      t.text :expected_skills
      t.date :start_at
      t.timestamp :expire_at, null: false

      t.timestamps
    end
  end
end
