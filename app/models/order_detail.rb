class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum making_status: { cannot: 0, nocreate: 1, creating: 2, finished: 3}

end
