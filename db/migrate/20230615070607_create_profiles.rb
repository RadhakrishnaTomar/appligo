class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles, id: :uuid do |t|
      t.uuid  :company_id
      t.string  :name
      t.string  :description
      t.string  :create_by
      t.timestamps
    end
  end
end
