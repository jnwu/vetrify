class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :name
      t.string :url
      t.date :started_at
      t.date :updated_at

      t.timestamps
    end
  end
end
