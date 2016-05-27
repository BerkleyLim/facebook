class User < ActiveRecord::Base
  # 글을 쓸 때, 누가 썼는지 확인하기  위함
  has_many :postings
  
  # 좋아요와 관련된 관계
  has_many :likeits
  has_many :stories, through: :likeits, class_name: :Posting
  
  # 친구와 관련된 관계
  has_many :friendships, foreign_key: :sender_id
  has_many :senders, through: :friendships, class_name: :User
  
  has_many :friendships, foreign_key: :recevier_id
  has_many :receivers, through: :friendships, class_name: :User
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
