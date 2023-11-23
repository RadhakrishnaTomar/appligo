class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans, id: :uuid do |t|
      t.string :name
      t.text :active_features, array: true, default: []
      t.decimal :price_per_year
      t.string :description
      t.timestamps
    end
  end
end
