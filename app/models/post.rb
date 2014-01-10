class Post < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description

  belongs_to :user
  belongs_to :category
  belongs_to :parent,
    class_name: 'Post'
end
