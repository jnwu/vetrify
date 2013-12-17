class CreateBusinessUsers < ActiveRecord::Migration
  def change
    create_table :business_users do |t|
      t.belongs_to :business, index: true
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :password
      t.string :password_digest

      t.timestamps
    end
    add_index :business_users, :email, unique: true
  end
end
