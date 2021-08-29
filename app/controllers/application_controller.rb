class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?



  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,
  			 keys: [:first_name, :last_name, :kana_first_name, :kana_last_name,
                :email, :postal_code, :residence, :phone_number])

      #sign_upの際にnameのデータ操作を許可。追加したカラム。
  		devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end


  def after_sign_in_path_for(resource)
    case resource
      when Admin
         admin_orders_path
      when Customer
        customer_path(resource)
    end
  end
  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      admin_session_path
    else
      root_path
    end
  end


end
