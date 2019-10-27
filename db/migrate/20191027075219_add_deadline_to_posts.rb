class AddDeadlineToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :deadline, :timestamp
  end
end
