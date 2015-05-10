class SeatsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_seat, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized
  after_action :verify_policy_scoped, :only => :index

  def index
    @seats = policy_scope(Seat).order(:row, :number)
    authorize @seats, :create?
    authorize @seats, :update?
    authorize @seats, :destroy?
    @seats = @seats.decorate
  end

  def new
    @users = User.all.decorate
    @seat = Seat.new
    authorize @seat, :create?
  end

  def edit
    @users = User.all.decorate
    authorize @seat, :update?
  end

  def create
    @seat = Seat.new(seat_params)
    authorize @seat

    respond_to do |format|
      if @seat.save
        format.html { redirect_to action: "index",
                      notice: 'Seat successfully created.' }
        format.json { render action: 'index', status: :created, location: @seat }
      else
        format.html { render action: 'new' }
        format.json { render json: @seat.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @seat, :update?
    respond_to do |format|
      if @seat.update(seat_params)
        format.html { redirect_to action: :index,
                      notice: 'Seat successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @seat.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @seat, :destroy?
    @seat.destroy
    respond_to do |format|
      format.html { redirect_to seats_url }
      format.json { head :no_content }
    end
  end

  private
  def set_seat
    @seat = Seat.find(params[:id])
  end

  def seat_params
    params.require(:seat).permit(:row, :number, :reserved, :user_id)
  end

end
