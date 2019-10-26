module ApplicationHelper
  def chose_data(id)
   @chose_datas  = Chose.where(posts_id: id)
  end
end
