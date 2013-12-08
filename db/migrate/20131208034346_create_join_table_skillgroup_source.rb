class CreateJoinTableSkillgroupSource < ActiveRecord::Migration
  def change
    create_join_table :skillgroups, :sources do |t|
      # t.index [:skillgroup_id, :source_id]
      # t.index [:source_id, :skillgroup_id]
    end
  end
end
