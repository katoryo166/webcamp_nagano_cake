class CreateOrderDetailes < ActiveRecord::Migration[5.2]
  def change
    create_table :order_detailes do |t|
      t.integer :item_id
      t.integer :order_id
      t.integer :price
      t.integer :amout
      t.integer :making_status
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
