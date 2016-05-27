class CreateLikeits < ActiveRecord::Migration
  def change
    create_table :likeits do |t|
      
      t.integer :user_id
      t.integer :posting_id
      
      t.timestamps null: false
    end
  end
end
