class AddProfileName < ActiveRecord::Migration
  def change
  	add_column :posts, :profile_service, :string
  end
end
