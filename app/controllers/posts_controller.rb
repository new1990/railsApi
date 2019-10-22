class PostsController < ApplicationController

  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def create
      @post = Post.new(post_params)
      if @post.save
        json_request = JSON.parse(request.body.read)
        @tasks = json_request["task"]['todo']
        @tasks.each do |index|
          @chose = Chose.new(name: index['name'],posts_id: @post.id,st_flg: 1)
          @chose.save
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
