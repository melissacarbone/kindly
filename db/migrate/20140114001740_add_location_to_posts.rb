class AddLocationToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :location, :string
  end

  def down
    remove_column :posts, :location
  end
end
