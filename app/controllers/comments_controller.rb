class CommentsController < ApplicationController
  def show
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:params_id])
    @comments = @post.comments
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post

    if @comment.save
      flash[:notice] = "2¢ notted"
      redirect_to [@topic, @post]
    else
      flash[:error] = "We were not paying attention so something went wrong, say that again..."
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
