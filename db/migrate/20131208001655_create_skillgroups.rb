class CreateSkillgroups < ActiveRecord::Migration
  def change
    create_table :skillgroups do |t|
	  t.belongs_to :skillable, polymorphic: true, null: false
      t.belongs_to :skill, index: true
      t.integer :proficiency, null: false

      t.timestamps
    end
  end
end
