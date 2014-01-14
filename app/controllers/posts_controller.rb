class PostsController < ApplicationController
  before_filter :authenticate_user!

  def index
    if params[:user_id]
      @posts = Post.where(user_id: params[:user_id]).order(date_completed: :desc, created_at: :desc)
      @link_path = posts_path
    else
      @posts = Post.order(date_completed: :desc, created_at: :desc).limit(10)
      @link_path = user_posts_path(current_user)
    end
  end

  def new
    @post = Post.new

    if params[:post_id]
      @parent = Post.find(params[:post_id])
      @target = [@parent, @post]
    else
      @target = @post
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.parent = Post.find(params[:post_id]) if params[:post_id]

    if @post.save
      redirect_to posts_path, notice: 'Success!'
    else
      @target = @post
      render 'new', notice: 'Post could not be saved'
    end
  end

  def show
    @post = Post.find(params[:id])
    @inspiration = Post.inspired_post_count(@post.id)
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id
      redirect_to posts_path, notice: 'Access Denied!'
    end
  end

  def update
    @post = Post.find(params[:id])
      if @post.update(post_params)
        redirect_to posts_path, notice: 'Updated Successfully!'
      else
        render 'edit', notice: 'Post could not be updated'
      end
  end

  def destroy
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id
      redirect_to posts_path, notice: 'Access Denied!'
    end
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully deleted'
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :location, :category_id, :date_completed)
  end
end
