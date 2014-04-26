class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, 
                                  :promote_to_admin, :demote_from_admin]
  before_filter :authenticate_user!
  after_action :verify_authorized, :except => [:index, :edit]

  # GET /users
  # GET /users.json
  def index
    @users = User.order('username asc')
  end

  # GET /users/new
  def new
    @user = User.new
    authorize @user, :create?
  end

  # GET /users/1/edit
  def edit
    @users = User.all
    authorize @user, :update?
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(seat_params)
    authorize @user, :create?

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    authorize @user, :update?
    if @user.update(seat_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    authorize @user, :destroy?
    redirect_to users_url
  end

  def promote_to_admin
    authorize @user, :promote?
    @user.promote_to_admin!
    redirect_to edit_user_path(@user)
  end

  def demote_from_admin
    authorize @user, :promote?
    @user.demote_from_admin!
    redirect_to edit_user_path(@user)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def seat_params
    params.require(:seat).permit(:email, :username)
  end

end
