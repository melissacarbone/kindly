class Post < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :category_id

  belongs_to :user
  belongs_to :category
  belongs_to :parent,
    class_name: 'Post'

  def self.inspired_post_count(params)
    where('parent_id = ?', params).count
  end

  # def self.search(query)

  #   where('category ilike ? OR description ilike ?', "%#{query}%", "%#{query}%")
  # end
end
