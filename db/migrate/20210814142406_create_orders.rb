class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :total_payment
      t.string :postal_code
      t.string :address
      t.string :name
      t.integer :shipping_cost
      t.integer :payment_method
      t.integer :status
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
