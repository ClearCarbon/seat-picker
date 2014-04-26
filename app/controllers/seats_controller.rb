class SeatsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_seat, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, :except => [:index, :edit]

  # GET /seats
  # GET /seats.json
  def index
    @seats = Seat.order('row asc', 'number asc')
  end

  # GET /seats/new
  def new
    @seat = Seat.new
    authorize @seat, :create?
  end

  # GET /seats/1/edit
  def edit
    @users = User.all
    authorize @seat, :create?
  end

  # POST /seats
  # POST /seats.json
  def create
    @seat = Seat.new(seat_params)
    authorize @seat, :create?

    respond_to do |format|
      if @seat.save
        format.html { redirect_to @seat, notice: 'Seat was successfully created.' }
        format.json { render action: 'show', status: :created, location: @seat }
      else
        format.html { render action: 'new' }
        format.json { render json: @seat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seats/1
  # PATCH/PUT /seats/1.json
  def update
    authorize @seat, :update?
    respond_to do |format|
      if @seat.update(seat_params)
        format.html { redirect_to @seat, notice: 'Seat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @seat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seats/1
  # DELETE /seats/1.json
  def destroy
    authorize @seat, :destroy?
    @seat.destroy
    respond_to do |format|
      format.html { redirect_to seats_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_seat
    @seat = Seat.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def seat_params
    params.require(:seat).permit(:row, :number, :user_id)
  end

end
