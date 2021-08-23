class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details

  validates :name, :address, :postal_code, :payment_method, presence: true

  def shipping
    (self.shipping_cost = 800).round
  end

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status:{ notpay: 0, paid: 1, creating: 2, preparation: 3, shipping: 4}

end
