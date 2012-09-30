class PostsController < ApplicationController

  respond_to :html

  before_filter :require_login, :only => [:edit, :update, :destroy]
  before_filter :find_post, :only => [:show, :edit, :update, :destroy]

  def index
    @posts = Post.order('created_at DESC')
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:notice] = "The post was successfully created."
      respond_with @post
    else
      render action: "new"
    end
  end

  def update
    if @post.update_attributes(params[:post])
      flash[:notice] = "The post was successfully updated."
      respond_with @post
    else
      render action: "edit"
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "The post was successfully deleted."
      respond_with @post
    else
      redirect_to posts_path
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

end
