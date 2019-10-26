class PostsController < ApplicationController

  def index
    page = 2
    @posts = Post.pager(page: params[:page], per: page)
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
            @chose = Chose.new(name: index['name'],posts_id: @post.id,st_flg: 1)
            @chose.save
          end
        end
        render :show, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
  end

  private
   def post_params
     params.fetch(:task, {}).permit(
         :title, :content
     )
   end

end
