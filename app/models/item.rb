class Item < ApplicationRecord

  belongs_to :genre
  has_many :cart_items
  has_many :order_details

  attachment :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, numericality: {only_integer: true}

  def add_tax_price
    (self.price * 1.1).round
  end

end
