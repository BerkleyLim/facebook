class HomeController < ApplicationController
  def index
    if user_signed_in?
      @post = Posting.all
    else
      redirect_to "/users/sign_in"
    end
  end
  
  def post
    new_post = Posting.new
    new_post.content = params[:content]
    new_post.user_id = current_user.id
    
    file = params[:picture]
    uploader = UploadUploader.new
    uploader.store!(file)
    new_post.file_name = uploader.url
    
    new_post.save
    
    redirect_to "/home/index"
  end
  
  def likeit
    #postt = Posting.find(params[:idofpost].to_i)
    @postid = params[:name].to_i
    
    likeit_list = Likeit.where(posting_id: @postid, user_id: current_user.id)
    
    if likeit_list.empty? # 좋아요를 아직 하지 않은 경우
      Likeit.new(user_id: current_user.id, posting_id: @postid).save
      
      @post = Posting.find(@postid)
      @like_email = @post.members
      
      respond_to do |format|
        format.js
      end
    else                  # 좋아요를 이미 한 경우
      likeit_list.take.destroy
      
      @post = Posting.find(@postid)
      @like_email = @post.members
      
      # link_to Ajax 과정
      respond_to do |format|
        format.js
      end
    end
  end
  
  def friend
    if user_signed_in?
      @users = User.all.where("id != ?", current_user.id)
    else
      redirect_to "/users/sign_in"
    end
  end
  
  def make_friend
    if params[:status] == "request"
      new_friend = Friendship.new(sender_id: current_user.id, receiver_id: params[:receiver], status: "request")
      new_friend.save
    elsif params[:status] == "accept"
      request_status = Friendship.where(sender_id: params[:receiver], receiver_id: current_user.id).take
      request_status.update(status: "friend")
    else
      
    end
    redirect_to "/home/friend"
  end
end
