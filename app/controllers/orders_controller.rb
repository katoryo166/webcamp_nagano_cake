class OrdersController < ApplicationController
  def index
  end

  def new
    @order = Order.new
    @customer = current_customer
    @addresses = Address.find_by(customer_id: current_customer.id)
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @cart_items.destroy
    redirect_to confirum_orders_path
  end

  def show
  end

  def confirum
    @cart_items = current_customer.cart_items
    @total_price = @cart_items.sum{|cart_item|cart_item.item.add_tax_price * cart_item.amount * 1.1}
    @order = Order.new(order_params)
      #addressesにresidenceの値
      if params[:order][:addresses] == "residence"
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.residence
        @order.name = current_customer.first_name + current_customer.last_name

      #addressesにaddressの値
      elsif params[:order][:addresses] == "addresses"
        @addresses = Address.find(params[:order][:address_id])
        @order.postal_code = @addresses.postal_code
        @order.address = @addresses.residence
        @order.name = @addresses.name

      #addressesにnew_addressの値
      elsif params[:order][:addresses] == "new_address"
        @order.postal_code = params[:order][:postal_code]
        @order.address = params[:order][:address]
        @order.name = params[:order][:name]
      end
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment)
  end

end
