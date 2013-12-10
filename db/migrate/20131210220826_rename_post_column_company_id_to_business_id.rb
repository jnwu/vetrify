class RenamePostColumnCompanyIdToBusinessId < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.rename :company_id, :business_id
    end
  end
end
