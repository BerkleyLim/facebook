class Likeit < ActiveRecord::Base   
  belongs_to :member, class_name: :User, foreign_key: :user_id
  belongs_to :story, class_name: :Posting, foreign_key: :posting_id
end
