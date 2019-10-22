class CreateChoses < ActiveRecord::Migration[5.2]
  def change
    create_table :choses do |t|
      t.integer :posts_id
      t.string :name
      t.integer :st_flg
      t.integer :count

      t.timestamps
    end
  end
end
