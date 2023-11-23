class CreateBulkUploads < ActiveRecord::Migration[7.0]
  def change
    create_table :bulk_uploads do |t|
      t.string :team_member_name
      t.string :team_member_id
      t.string :integer

      t.timestamps
    end
  end
end
