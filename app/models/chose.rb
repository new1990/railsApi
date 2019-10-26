class Chose < ApplicationRecord
   belongs_to :posts,  class_name: 'Post',foreign_key: "posts_id"


end
