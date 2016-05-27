class Posting < ActiveRecord::Base
  # 글을 쓸 때, 누가 썼는지 확인하기  위함
  belongs_to :user
  
  # 좋아요와 관련된 관계
  has_many :likeits
  has_many :members, through: :likeits, class_name: :User
end
