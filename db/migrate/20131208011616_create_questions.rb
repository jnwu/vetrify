class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.belongs_to :post, index: true
      t.string :description

      t.timestamps
    end
    add_index :questions, :description, unique: true
  end
end
