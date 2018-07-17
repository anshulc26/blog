class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.integer :user_id
      t.string :title
      t.string :image_id
      t.string :image_url_original
      t.string :image_url_thumb
      t.text :description
      t.boolean :show, default: false
      t.string :slug
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :blog_posts, :slug
    add_index :blog_posts, :deleted_at
  end
end
