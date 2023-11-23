class ChangeIntoBulkUploads < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    change_table :bulk_uploads, id: :uuid do |t|
      t.remove :id
      t.uuid :id, default: 'gen_random_uuid()', primary_key: true
    end
  end
end
