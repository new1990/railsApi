class AddContentToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :content, :string
    add_column :posts, :bad_count, :integer
    add_column :posts, :good_count, :integer
    add_column :posts, :st_flg, :integer
    add_column :posts, :user_id, :integer
  end
end
