class CreatePostings < ActiveRecord::Migration
  def change
    create_table :postings do |t|
      
      t.text    :content
      t.string  :file_name, default: ""
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
