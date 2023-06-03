class LikesController < ApplicationController

  before_action :authenticate_user!#サインイン済みユーザーのみいいねができる

  def create
    @like = current_user.likes.build(like_params)
    #buildメソッドを使ってインスタンスを作成し、like_paramsというメソッドを引数で呼び出している。
    #いいねを押したときに、どの投稿にいいねを押したのかpost_idの情報を変更できる
    #current_user.likesはアソシエーションのおかげ。current_userのlikes
    @post = @like.post#@likeに紐づく投稿の情報を持ってくる。
    #@likeには以下のようにpost_idとuser_idの情報が入っている。
    #id: nil, post_id: 5, user_id: 1, created_at: nil, updated_at: nil => user_idは現在サインインしているuserのid
    if @like.save
      respond_to :js
      #返却するレスポンスのフォーマットを切り替えるためのメソッド
      #いいねを押したらリアルタイムでビューを反映させるためにフォーマットをJS形式でレスポンスを返すようにしている。
    end
  end

  def destroy
    @like = Like.find_by(id: params[:id])#受け取ったHTTPリクエストからidを判別し、指定のレコード1つを@likeに代入
    @post = @like.post
    if @like.destroy
      respond_to :js
    end
  end

  private
    def like_params
      params.permit(:post_id)
      #paramsとは送られてきたリクエスト情報をひとまとめにしたもの
      #permitで変更を加えられるキーを指定
    end

end
