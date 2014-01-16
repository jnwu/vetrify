class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.belongs_to :applicant, index: true
      t.belongs_to :business, index: true
      t.string :name
      t.text :summary
      t.date :started_at
      t.date :ended_at

      t.timestamps
    end
  end
end
