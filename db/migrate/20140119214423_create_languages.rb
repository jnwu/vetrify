class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.belongs_to :repo, index: true
      t.belongs_to :skill, index: true
      t.float :percent

      t.timestamps
    end
  end
end
