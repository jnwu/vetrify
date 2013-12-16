class CreateJoinTableApplicantPost < ActiveRecord::Migration
  def change
    create_join_table :applicants, :posts do |t|
      # t.index [:applicant_id, :post_id]
      # t.index [:post_id, :applicant_id]
    end
  end
end
