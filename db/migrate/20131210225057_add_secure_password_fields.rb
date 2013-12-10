class AddSecurePasswordFields < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.string :password_digest
    end

    change_table :business_users do |t|
      t.string :password_digest
    end
  end
end
