class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.date :date, null: false
      t.integer :category_id
    end
  end
end
