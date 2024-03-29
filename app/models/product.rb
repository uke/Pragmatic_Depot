class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title

  validates :title, :description, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true, :length => { :minimum => 10 }
  validates :image_url, allow_blank: true, format: {
  	with: %r{\.(gif|jpg|png)\Z}i,
  	message: 'Must be url for gif, jpg or png image.'
  }
end
