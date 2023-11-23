class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions, id: :uuid do |t|
      t.string :company_id, type: :uuid, foreign_key: true
      t.string :subscribed_app
      t.datetime :start_date
      t.datetime :end_date
      t.references :plan, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
