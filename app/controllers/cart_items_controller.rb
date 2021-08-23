class CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    #sumメソッド：合計金額を出す
     @total_price = @cart_items.sum{|cart_item|cart_item.item.add_tax_price * cart_item.amount * 1.1}
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    #カートの中に同じ商品が重複しないようにして数量を合わせる
    if @cart_item.save
        flash[:notice] = "#{@cart_item.item.name}をカートに追加しました。"
        redirect_to cart_items_path
    else
      flash[:notice] = "個数を選択してください"
      render "items/show"
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])

    @update_cart_item = CartItem.find(item: @cart_item.item)
      if @update_cart_item.present? && @cart_item.valid?
        @cart_item.amount += @update_cart_item.amount
        @update_cart_item.destroy
      end

    @cart_item.update(cart_item_params)
    @total = total_price(@cart_items).to_s(:delimited)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_item = current_customer.cart_items
    @cart_item.destroy_all
    flash[:notice] = "カートの商品を全て削除しました"
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end

end

