class CommentsController < ApplicationController
  def create
    product_id = params[:product_id]
    message = params[:message]
    @comment = current_user.comments.new product_id: product_id, message: message

    if @comment.save
      respond_to do |format|
        format.js do
          render json: {
            html: render_to_string(partial: "/comments/comment",
              locals: {comment: @comment})
          }
        end
      end
    else
      redirect_to :back
    end
  end
end
