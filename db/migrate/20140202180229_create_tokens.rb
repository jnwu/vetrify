class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.belongs_to :applicant, index: true
      t.string :key

      t.timestamps
    end
    add_index :tokens, :key, unique: true
  end
end
