class ApplicationController < ActionController::Base
  # devise利用の機能（ユーザー登録、ログイン認証など）が行われる場合、その前にconfigure_permitted_parametersが実行される。
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # configure_permitted_parametersでは、devise_parameter_sanitizer.permitで、nameのデータ操作を許可するアクションメソッドが指定されている。
  # 今回のケースでは、ユーザー登録（sign_up）の際に、ユーザー名（name）のデータ操作が許可される。
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # ユーザー情報の更新時（account_update）にもユーザ名（name）のデータ操作が許可される。
    # devise_parameter_sanitizer.permit(:account_update, keys: [:name]) 
  end
end
