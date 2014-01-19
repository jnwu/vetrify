class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.belongs_to :applicant, index: true
      t.string :school
      t.string :degree
      t.string :field
      t.integer :started_at
      t.integer :ended_at

      t.timestamps
    end
  end
end
