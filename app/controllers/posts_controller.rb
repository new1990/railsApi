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
    nowis = Time.new
    @posts = Post.find(params[:id])
    if @posts.deadline >= nowis
      @deadline_flag = 0
    else
      @deadline_flag = 1
    end

    render 'show', formats: 'json', handlers: 'jbuilder'
    # render json: @post
  end

  def create
      json_request = JSON.parse(request.body.read)
      title = json_request["task"]["title"]
      content = json_request["task"]["content"]
      day = json_request["task"]["day"]
      hour = json_request["task"]["hour"]
      nowis = Time.new
      deadline = nowis + day*60*60*24 + hour*60*60
      @post = Post.new(title: title,content: content,deadline: deadline)
      # @post = Post.new(post_params)
      if @post.save

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
   # def post_params
   #   params.fetch(:task, {}).permit(
   #       :title, :content,:day ,:hour
   #   )
   # end

   def comment_params
     params.fetch(:comment, {}).permit(
         :body, :posts_id
     )
   end




end
