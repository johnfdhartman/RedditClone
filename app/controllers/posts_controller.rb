class PostsController < ApplicationController

  before_action only:[:update] do
    @post = Post.find(params[:id])
    require_author(@post)
  end

  before_action :require_login, except: [:show]

  def new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_id = params[:sub_id]
    if @post.save
      redirect_to sub_post_url(@post.sub, @post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])

  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to sub_post_url(@post.sub, @post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
  end

  def require_author(post)
    unless post.author_id == current_user.id
      redirect_to sub_post_url(post.sub, post)
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
end
