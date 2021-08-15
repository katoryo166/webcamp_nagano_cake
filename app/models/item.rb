class Item < ApplicationRecord

  belongs_to :genre
  attachment :image
  def add_tax_price
    (self.price * 1.08).round
  end
end
