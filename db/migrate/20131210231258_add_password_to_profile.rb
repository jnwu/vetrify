class AddPasswordToProfile < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.string :password
    end
  end
end
