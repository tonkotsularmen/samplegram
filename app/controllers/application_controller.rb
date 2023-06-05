class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception#クロスサイトリクエストフォージュエリ(CSRF)への対応策のコード(セキュリティ)

  before_action :configure_permitted_parameters, if: :devise_controller?
  #configure_permitted_parametersというメソッドはdevise_controllerを使う時しか処理しない

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :username])
    end
    #nameカラムを保存できるようにする記述はサインアップやアカウントをアップデートするときだけにしか必要がない。
end
