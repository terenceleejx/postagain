class BufferToken < ActiveRecord::Migration
  def change
  	add_column :users, :buffer_token, :text
  end
end
