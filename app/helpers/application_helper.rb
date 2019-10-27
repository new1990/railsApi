module ApplicationHelper
  def chose_data(id)
   @chose_datas  = Chose.where(posts_id: id)
  end

  def comment_data(id)
    @comment_datas  = Comment.where(posts_id: id)
  end
end
