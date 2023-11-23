class CreateInterview < ActiveRecord::Migration[7.0]
  def change
    create_table :interviews, id: :uuid do |t|
      t.uuid :applicant_id
      t.uuid :team_member_id
      t.string :title
      t.datetime :interview_date
      t.integer :status
      
      t.timestamps
    end
  end
end
