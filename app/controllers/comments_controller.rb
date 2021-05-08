class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_data)
    if @comment.save
      redirect_to prototype_path(@comment.id)
    else
      @comment = Comment.new(comment_data)
      @prototype = @comment.prototype
      render template: "prototypes/show"
    end
  end

  private
  def comment_data
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
