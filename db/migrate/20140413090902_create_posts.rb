class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :text
      t.integer :user_id
      t.string :profile_id
      t.string :buffer_post_id
      t.string :buffer_user_id
      t.integer :created_at
      t.string :day
      t.integer :due_at
      t.string :due_time
      t.text :statistics
    end
  end
end
