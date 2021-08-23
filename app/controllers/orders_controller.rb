class OrdersController < ApplicationController

  def index
    @orders = current_customer.orders
  end

  def new
    @order = Order.new
    @customer = current_customer
    @addresses = Address.find_by(customer_id: current_customer)
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    #byebug
    @order.save
    # カート商品の情報を注文商品に移動
    @cart_items = current_customer.cart_items
       @cart_items.each do |cart_item|
        OrderDetail.create(
      item:  cart_item.item,
      order:    @order,
      amount: cart_item.amount

    )
  end
    @cart_items.destroy_all
    redirect_to thanks_orders_path
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

  def thanks
  end

  def show
     @order = Order.find(params[:id])
     @order_details = @order.order_details
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment)
  end

end
