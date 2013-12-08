class CreateJoinTableProfilePost < ActiveRecord::Migration
  def change
    create_join_table :profiles, :posts do |t|
      # t.index [:profile_id, :post_id]
      # t.index [:post_id, :profile_id]
    end
  end
end
