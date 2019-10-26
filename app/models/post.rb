class Post < ApplicationRecord
  has_many :choses,  class_name: 'Chose', foreign_key: "posts_id"

  scope :pager, ->(page: 1, per: 10) {
    num = page.to_i.positive? ? page.to_i - 1 : 0
    limit(per).offset(per * num)
  }
  
end
