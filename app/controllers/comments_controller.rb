class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def create
    @comment = Comment.new(comment_data)
    @prototype = Prototype.find(params[:prototype_id])
    if @comment.save
      redirect_to prototype_path(@comment.prototype.id)
    else
      @comments = @prototype.comments.includes(:user)
      # @prototype = @comment.prototype
      render template: "prototypes/show"
    end
  end

  private
  def comment_data
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
