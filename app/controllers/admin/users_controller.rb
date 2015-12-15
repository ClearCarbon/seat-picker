class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy,
                                  :promote_to_admin, :demote_from_admin]
  after_action :verify_authorized, except: [:index]
  after_action :verify_policy_scoped, only: :index
  respond_to :html

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
    @user = User.new(user_params)
    authorize @user, :create?
    @user.password = SecureRandom.hex(8)

    StandardUpdater.new(StandardResponder.new(self)).update(@user, user_params)
  end

  def update
    authorize @user, :update?

    StandardUpdater.new(StandardResponder.new(self)).update(@user, user_params)
  end

  def destroy
    authorize @user, :destroy?

    StandardDestroyer.new(StandardResponder.new(self)).destroy(@user)
  end

  def promote_to_admin
    authorize @user, :promote?
    @user.promote_to_admin!
    @user = @user.decorate
    flash[:notice] = "'#{@user.username}' has been promoted to admin."
    redirect_to edit_admin_user_path(@user)
  end

  def demote_from_admin
    authorize @user, :promote?
    @user.demote_from_admin!
    @user = @user.decorate
    flash[:notice] = "'#{@user.username}' has been demoted to a regular user."
    redirect_to edit_admin_user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :username, :seat)
  end
end
