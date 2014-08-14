class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, 
                                  :promote_to_admin, :demote_from_admin]
  before_filter :authenticate_user!
  after_action :verify_authorized, :except => [:index]
  after_action :verify_policy_scoped, :only => :index

  def index
    @users = policy_scope(User).order(:email)
  end

  def new
    @user = User.new
    authorize @user, :create?
  end

  def edit
    authorize @user, :update?
  end

  def create
    binding.pry
    @user = User.new(user_params)
    authorize @user, :create?

    if @user.save
      redirect_to [:users], notice: 'User successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    authorize @user, :update?
    if @user.update(user_params)
      redirect_to action: :index, notice: 'User successfully updated'
    else
      render action: 'edit'
    end
  end

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
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :username, :seat)
  end

end
