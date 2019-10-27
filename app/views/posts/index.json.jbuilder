

json.array! @posts do |posts|
  json.id posts.id
  json.title  posts.title
  json.content  posts.content

  chose_data(posts.id)

  json.cdata do
    json.array! @chose_datas do |chose|
      json.chose_id chose.id
      json.chose_title chose.name
      json.chose_count chose.count
    end
  end



end
