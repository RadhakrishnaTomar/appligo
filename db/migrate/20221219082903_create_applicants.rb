class CreateApplicants < ActiveRecord::Migration[7.0]
  def change
    create_table :applicants do |t|
      t.string :designation_name
      t.string :name
      t.string :contact_number
      t.string :email
      t.text   :location
      t.float :last_salary
      t.float :expected_ctc
      t.text   :notice_period
      t.boolean :open_for
      t.string :source
      t.timestamps
    end
  end
end
