class PostsController < ApplicationController
  before_filter :authenticate_user!,
    only: [:new, :index, :show]

  def index
    @posts = Post.all
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
    params.require(:post).permit(:title, :description, :date)
  end
end
