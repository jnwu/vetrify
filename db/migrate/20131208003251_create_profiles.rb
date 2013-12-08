class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email

      t.timestamps
    end
    add_index :profiles, :email, unique: true
  end
end
