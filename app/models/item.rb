class Item < ApplicationRecord

  belongs_to :genre
  has_many :cart_items
  belongs_to :order

  attachment :image

  def add_tax_price
    (self.price * 1.1).round
  end

end
