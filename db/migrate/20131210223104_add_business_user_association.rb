class AddBusinessUserAssociation < ActiveRecord::Migration
  def change
    change_table :business_users do |t|
      t.belongs_to :business, index: true
    end
  end
end
