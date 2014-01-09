class PostsController < ApplicationController
  before_filter :authenticate_user!,
    only: [:new, :index, :show]

  def index
    if params[:user_id]
      @posts = Post.where(user_id: params[:user_id])
      @link_path = posts_path
    else
      @posts = Post.order('created_at DESC').limit(10)
      @link_path = user_posts_path(current_user)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to @post, notice: 'Success!'
    else
      render 'new', notice: 'Post could not be saved'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :description)
  end
end
