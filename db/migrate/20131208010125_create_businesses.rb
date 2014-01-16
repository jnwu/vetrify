class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :business_type
      t.integer :founded_year
      t.string :status
      t.string :location
      t.integer :size
      t.string :stock_exchange
      t.string :ticker
      t.text :specialties
      t.text :culture
      
      t.string :domain
      t.string :url
      t.string :twitter
      t.string :facebook
      t.string :linkedin

      t.timestamps
    end
    add_index :businesses, :name, unique: true
  end
end
