class CommentsController < ApplicationController
  def create
    product_id = params[:product_id]
    message = params[:message]
    @comment = current_user.comments.new product_id: product_id, message: message

    if @comment.save
      respond_to do |format|
        format.js do
          render json: {
            save_success: true,
            html: render_to_string(partial: "/comments/comment",
              locals: {comment: @comment})
          }
        end
      end
    else
      flash[:danger] = t "flash.danger.comment_fail_message"
      respond_to do |format|
        format.js do
          render json: {
            save_success: false,
            html: render_to_string(partial: "/layouts/flash",
              locals: {flash: flash})
          }
        end
      end
    end
  end
end
