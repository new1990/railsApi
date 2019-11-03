
  json.id @posts.id
  json.title  @posts.title
  json.content  @posts.content
  json.show_flg @deadline_flag

  chose_data(@posts.id)

  json.cdata do
    json.array! @chose_datas do |chose|
      json.chose_id chose.id
      json.chose_title chose.name
      json.chose_count chose.count
    end
  end

  comment_data(@posts.id)

  json.comment_data do
    json.array! @comment_datas do |comment|
      json.comment_id comment.id
      json.comment_body comment.body
    end
  end
