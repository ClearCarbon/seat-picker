class PickerController < ApplicationController
  before_action :authenticate_user!
  before_action :set_seat, only: [:pick, :make_request, :cancel_request]

  def index
    @seats = SeatDecorator.decorate_collection(Seat.order('row asc', 'number asc'))
  end

  def pick
    respond_to do |format|
      authorize @seat, :pick?
      if @seat.update_attributes(user_id: current_user.id)
        format.json { head :no_content }
      else
        format.json { render json: @seat.errors, status: :unprocessable_entity }
      end
    end
  end

  def make_request
    respond_to do |format|
      if SeatRequest.create(user: current_user, seat: @seat)
        format.json { head :no_content }
      else
        format.json { render json: @seat.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel_request
    respond_to do |format|
      seat_request = current_user.seat_requests.where(seat_id: @seat.id).first
      authorize seat_request, :cancel_request?
      if seat_request && seat_request.destroy
        format.json { head :no_content }
      else
        format.json { render json: @seat.errors, status: :unprocessable_entity }
      end
    end
  end

  def give_up
    respond_to do |format|
      authorize current_user.seat, :give_up?
      if current_user.seat.update_attributes(user_id: nil)
        format.json { head :no_content }
      else
        format.json { render json: @seat.errors, status: :unprocessable_entity }
      end
    end
  end

  def donate_seat
    respond_to do |format|
      seat_request = SeatRequest.find(params[:seat_request_id])
      authorize seat_request, :donate?
      if seat_request.seat.user == current_user
        seat_request.seat.user = seat_request.user
        seat_request.seat.save
        seat_request.destroy
      end
      format.json { head :no_content }
      format.html {
        redirect_to picker_index_path
      }
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
