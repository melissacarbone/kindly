class Post < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :date

  belongs_to :category
end
