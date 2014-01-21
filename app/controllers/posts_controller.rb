class PostsController < ApplicationController
  before_filter :authenticate_user!

  def index
    if params[:user_id]
      @posts = Post.where(user_id: params[:user_id]).order(date_completed: :desc, created_at: :desc)
    else
      @posts = Post.order(date_completed: :desc, created_at: :desc).where('date_completed IS NOT NULL').limit(15)
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
      flash[:notice] = "Post was successfully submitted!"
      redirect_to posts_path
    else
      flash[:notice] = "Post could not be saved."
      @target = @post
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    @inspiration = @post.inspired_post_count
    @children = @post.children
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id
      flash[:notice] = "Access Denied"
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
      if @post.update(post_params)
        flash[:notice] = "Updated Successfully!"
        redirect_to posts_path
      else
        flash[:notice] = "Post could not be updated."
        render 'edit'
      end
  end

  def destroy
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id
      flash[:notice] = "Access Denied"
      redirect_to posts_path
    end
    @post.destroy
    flash[:notice] = "Post was successfully deleted."
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :location, :category_id, :date_completed)
  end
end
