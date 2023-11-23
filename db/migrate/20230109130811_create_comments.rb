class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments, id: :uuid do |t|
      t.uuid  :commentable_id
      t.string  :commentable_type
      t.text    :content
      t.timestamps
    end
    add_index :comments, [:commentable_type, :commentable_id]
  end
end
