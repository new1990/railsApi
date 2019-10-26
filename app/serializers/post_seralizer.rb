class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content
  has_many :choses,  class_name: 'Chose', foreign_key: "posts_id"

  class ChoseSerializer < ActiveModel::Serializer
    attributes :id, :name
  end

end
