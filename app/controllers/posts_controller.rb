class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @post = Post.new# id: nil, caption: nil, user_id: nil, created_at: nil, updated_at: nilのインスタンスを作っている
    @post.photos.build# Railsの慣習でモデルを関連付けしたときにbuildを使う。
  end
  
  def create
    @post = Post.new(post_params)#post_paramsを引数にしてnewメソッドでインスタンスを作成している
    if @post.photos.present?#投稿の写真が存在するか確認している。present?はnilまたは空のオブエクトでなければtrueを返します。
      @post.save#saveメソッドはオブジェクトをデータベースに保存できる。
      redirect_to root_path#指定したページに遷移する。
      flash[:notice] = "投稿が保存されました"
    else
      redirect_to root_path
      flash[:alert] = "投稿に失敗しました"
    end
  end
  
  def index
    @posts = Post.limit(10).includes(:photos, :user).order('created_at DESC')
    #limitメソッドは取り出すレコード数の上限を指定する。
    #orderメソッドはDBから取り出すレコードを特定の順番で並べたい時に使用する。
    #order('created_at DESC')とすることで、created_atのDESC(降順)、=> 投稿された最新の日時順に並び替える。
    #.includes(:photos, :user)でN+1問題が解決する。
  end

  private
    def post_params
      params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
      #paramsとは送られてきたリクエスト情報一つにまとめたもの。
      #requireで受け取る値のキーを設定します。
      #permitで変更を加えられるキーを指定する。今回はcaptionキーとimageキーを指定している。
      #mergeメソッドは２つの8種を統合するメソッド。今回は誰が投稿したのかという情報が必要なためuser_idの情報を統合している。
    end
    
end
