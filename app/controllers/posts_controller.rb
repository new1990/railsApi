class PostsController < ApplicationController
require "time"

  def index
    page = 2
    nowis = Time.new
    @posts = Post.pager(page: params[:page], per: page).where('(deadline >= ?) or (deadline = ?)', nowis,nil)
    # @posts = Post.all
    # @chose = Chose.joins(:posts)
    # render json: @posts
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def result
    page = 2
    nowis = Time.new
    @posts = Post.pager(page: params[:page], per: page).where('(deadline <= ?) or (deadline = ?)', nowis,nil)
    # @posts = Post.all
    # @chose = Chose.joins(:posts)
    # render json: @posts
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def show
    @posts = Post.find(params[:id])
    render 'show', formats: 'json', handlers: 'jbuilder'
    # render json: @post
  end

  def create
      @post = Post.new(post_params)
      if @post.save
        json_request = JSON.parse(request.body.read)
        @tasks = json_request["task"]['todo']
        @tasks.each do |index|
          if index['name'].empty?
          else
            @chose = Chose.new(name: index['name'],posts_id: @post.id,st_flg: 1,count: 0)
            @chose.save
          end
        end
        render 'cre_success', formats: 'json', handlers: 'jbuilder'
      else
        render 'cre_error', formats: 'json', handlers: 'jbuilder'
      end
  end

  def comment_create
      @comment = Comment.new(comment_params)
      if @comment.save
        render 'cre_success', formats: 'json', handlers: 'jbuilder'
      else
        render 'cre_error', formats: 'json', handlers: 'jbuilder'
      end
  end

  def update
    @chose = Chose.find(params[:id])
    @count = @chose.count + 1
    if @chose.update(count: @count)
      render 'up_success', formats: 'json', handlers: 'jbuilder'
    else
      render 'up_error', formats: 'json', handlers: 'jbuilder'
    end
  end

  private
   def post_params
     params.fetch(:task, {}).permit(
         :title, :content
     )
   end

   def comment_params
     params.fetch(:comment, {}).permit(
         :body, :posts_id
     )
   end




end
