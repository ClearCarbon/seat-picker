class PickerController < ApplicationController
  before_action :authenticate_user!
  before_action :set_seat, only: [:pick, :give_up, :make_request]

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

  def make_request
    respond_to do |format|
      if SeatMailer.new_request(@seat).deliver
        format.json { head :no_content }
      else
        format.json { render json: @seat.errors, status: :unprocessable_entity }
      end
    end
  end

  def give_up
    respond_to do |format|
      if @seat.update_attributes(user_id: nil)
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
