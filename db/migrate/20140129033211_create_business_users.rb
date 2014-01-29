class CreateBusinessUsers < ActiveRecord::Migration
  def change
    create_table :business_users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :title

      t.timestamps
    end
    add_index :business_users, :email, unique: true
  end
end
