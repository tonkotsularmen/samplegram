class UsersController < ApplicationController
  
  def show
    @user = User.find_by(id: params[:id])#find_byは与えられた条件にマッチするレコードのうち最初のレコードだけを返す
  end#paramsは送られてきたリクエスト情報をひとまとめにして、params[:パラメータ名]という形式で取得できる
     #送られてくるリクエストは「GET /users/1」みたいな感じ
  
end
