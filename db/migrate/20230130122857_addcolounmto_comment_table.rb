class AddcolounmtoCommentTable < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :team_member_id, :uuid
  end
end
