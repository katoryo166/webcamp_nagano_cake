class OrdersController < ApplicationController
  def index
  end

  def new
    @order = Order.new
    @customer = current_customer
    @addresses = Address.find_by(customer_id: current_customer.id)
  end

  def show
  end
end
