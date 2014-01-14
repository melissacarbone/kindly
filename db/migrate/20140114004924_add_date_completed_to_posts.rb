class AddDateCompletedToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :date_completed, :datetime
  end

  def down
    remove_column :posts, :date_completed
  end
end
