module RatingsHelper
  def response_success product
    product.reload
    flash.now[:success] = t "flash.success.send_your_rating_success"
    respond_to do |format|
      format.js do
        render json: {
          save_success: true,
          html_rating_poin: product.rating_point.to_s << " " << t(".points"),
          html_flash: render_to_string(partial: "/layouts/flash",
            locals: {flash: flash})
        }
      end
    end
  end

  def response_fail
    flash.now[:danger] = t "flash.fail.send_your_rating_fail"
    respond_to do |format|
      format.js do
        render json: {
          save_success: false,
          html_flash: render_to_string(partial: "/layouts/flash",
            locals: {flash: flash})
        }
      end
    end
  end
end
