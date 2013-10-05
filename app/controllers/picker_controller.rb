class PickerController < ApplicationController
  before_filter :authenticate_user!

  def index
    @seats = Seat.order('row asc', 'number asc')
  end

  def pick
    respond_to do |format|
      if @seat.update(seat_params)
        format.json { head :no_content }
      else
        format.json { render json: @seat.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def seat_params
    params.require(:seat).permit(:user_id)
  end

end
