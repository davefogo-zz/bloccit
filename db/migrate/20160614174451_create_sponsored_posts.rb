class CreateSponsoredPosts < ActiveRecord::Migration
  def change
    create_table :sponsored_posts do |t|
      t.string :title
      t.text :body
      t.integer :price
      t.integer :topic_id

      t.timestamps null: false
    end
    add_index :sponsored_posts, :topic_id
  end
end
