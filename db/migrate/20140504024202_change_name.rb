class ChangeName < ActiveRecord::Migration
  def change
  	rename_column :posts, :delete, :remove
  end
end
