class User < ActiveRecord::Base
  has_many :posts, dependent: :nullify

  mount_uploader :image, ImageUploader

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email

  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
