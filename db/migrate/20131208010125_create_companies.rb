class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :company_type, null: false
      t.integer :founded_year, null: false
      t.string :status, null: false
      t.string :location, null: false
      t.integer :size, null: false
      t.string :stock_exchange
      t.string :ticker
      t.text :specialties, null: false
      t.text :culture
      
      t.string :domain, null: false
      t.string :url, null: false
      t.string :twitter
      t.string :facebook
      t.string :linkedin, null: false

      t.timestamps
    end
    add_index :companies, :name, unique: true
  end
end
