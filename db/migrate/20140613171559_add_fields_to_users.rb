class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fullname, :string, null: false, default: ""
    add_column :users, :username, :string, null: false, default: ""
    add_column :users, :photo_id, :string
    add_column :users, :photo_url_original, :string
  	add_column :users, :photo_url_thumb, :string
  	add_column :users, :allowed_to_post, :boolean, default: false
  	add_column :users, :allowed_to_comment, :boolean, default: true
    add_column :users, :deleted_at, :datetime

  	add_index :users, :username, unique: true
    add_index :users, :deleted_at
  end
end
