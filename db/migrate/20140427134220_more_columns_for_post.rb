class MoreColumnsForPost < ActiveRecord::Migration
  def change
  	add_column :posts, :media, :text
  end
end
