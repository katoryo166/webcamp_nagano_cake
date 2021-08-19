class Order < ApplicationRecord

  has_many :customer
  belongs_to :items
  belongs_to :order_detailes

  enum payment_method:{ credit_card: 0, transfer: 1}

end
