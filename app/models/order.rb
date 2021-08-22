class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_detailes

  def shipping
    (self.shipping_cost = 800).round
  end

  enum payment_method: { credit_card: 0, transfer: 1 }

end
