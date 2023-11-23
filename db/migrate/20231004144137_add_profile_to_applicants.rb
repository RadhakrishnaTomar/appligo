class AddProfileToApplicants < ActiveRecord::Migration[7.0]
  def change
    add_reference :applicants,:profile,type: :uuid,foreign_key: true
  end
end
