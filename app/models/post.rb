class Post < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :category_id

  belongs_to :user
  belongs_to :category
  belongs_to :parent,
    class_name: 'Post'

    def inspired_post_count
    count = 0
    children = Post.where('parent_id = ?', id)
    count += children.count
    children.each do |child|
      count += child.inspired_post_count
    end
    count
  end
end
