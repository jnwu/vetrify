class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :image

      t.timestamps
    end
    add_index :applicants, :email, unique: true
  end
end
