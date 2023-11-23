class RemoveColumnIntoBulkUploads < ActiveRecord::Migration[7.0]
  def change
    remove_column :bulk_uploads, :integer
  end
end
