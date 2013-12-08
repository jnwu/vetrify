class CreateJoinTableQuestionVideo < ActiveRecord::Migration
  def change
    create_join_table :questions, :videos do |t|
      # t.index [:question_id, :video_id]
      # t.index [:video_id, :question_id]
    end
  end
end
