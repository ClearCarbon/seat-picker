class UsersController < ApplicationController
  before_action :set_user, only: [:destroy]
  before_filter :authenticate_user!
  after_action :verify_authorized
  respond_to :html

  def cancel_account
    @user = current_user
    authorize @user, :destroy?
  end

  def destroy
    authorize @user, :destroy?

    StandardDestroyer.new(StandardResponder.new(self,
    redirect_path: new_user_session_path,
    success_text: 'Your account has been deleted.')).destroy(@user)
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :username, :seat)
    end

end
