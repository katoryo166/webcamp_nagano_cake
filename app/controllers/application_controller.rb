class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
      when Admin
         admin_items_path
      when Customer
        items_path
    end
  end
  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,
  			 keys: [:first_name, :last_name, :kana_first_name, :kana_last_name,
                :email, :postal_code, :residence, :phone_number])

      #sign_upの際にnameのデータ操作を許。追加したカラム。
  		devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end


end
