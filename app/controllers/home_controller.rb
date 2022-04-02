class HomeController < ApplicationController
  before_action :authenticate_user!
  layout 'user'
  def index
    @posts      = Post.all.order(:create_at)
    @users      = User.all
    @LikePost   = LikePost.all
    @seguidor   = Seguidor.all
  end

  def curtidas
    @postsLikeds = Post.all.where(id: LikePost.all.where(user_id: current_user.id).order(:create_at).pluck(:post_id))
    @users       = User.all
    @LikePost    = LikePost.all
    @seguidor    = Seguidor.all
  end

  def usuarios
    @users = User.all.where.not(id: current_user.id).consultaUsuarioNome(params[:nome])
    @seguidor = Seguidor.all
  end
  def visualizar
  end
  def notificacao
  end
  def dar_like_post
    @liked = LikePost.where(user_id: params[:user_id],post_id: params[:post_id])
    if @liked.size != 0
      LikePost.where(user_id: params[:user_id],post_id: params[:post_id]).take.delete
    else
      LikePost.create(user_id: params[:user_id],post_id: params[:post_id])
    end
    redirect_to root_path
  end

  def seguir
    @seguidor = Seguidor.where(seguidor: params[:seguidor],seguido: params[:seguido])
    if @seguidor.size > 0
      @seguidor.take.delete
    else
      Seguidor.create(seguidor: params[:seguidor],seguido: params[:seguido])
    end
    redirect_to usuarios_path
  end

end
