class User < ActiveRecord::Base
  has_many :posts

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
