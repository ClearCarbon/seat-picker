class PickerController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_seat, only: [:pick]

  def index
    @seats = Seat.order('row asc', 'number asc')
  end

  def pick
    respond_to do |format|
      if @seat.update_attributes(user_id: current_user.id)
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

  def set_seat
    @seat = Seat.find(params[:id])
  end

end
