class CustomersController < ApplicationController
  def show
     @customer = current_customer
  end

  def edit
     @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to customer_path
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_active: false)
    reset_session

  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :kana_first_name, :kana_last_name,:email, :postal_code, :residence, :phone_number, :is_active)
  end
end
