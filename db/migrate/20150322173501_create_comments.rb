class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.references :blog_post, index: true
      t.text :message
      t.datetime :deleted_at

      t.timestamps
    end
    
    add_index :comments, :deleted_at
  end
end
