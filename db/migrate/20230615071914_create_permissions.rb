class CreatePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :permissions, id: :uuid do |t|
      t.uuid :company_id, null: false
      t.uuid :role_id, null: false
      t.string :model_title, null: false
      t.boolean :read_p, default: false, null: false
      t.boolean :write_p, default: false, null: false
      t.boolean :delete_p, default: false, null: false
      
      t.timestamps
    end
  end
end
