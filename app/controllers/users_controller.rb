class UsersController < ApplicationController
  before_action :set_user, only: [:destroy]
  before_filter :authenticate_user!
  after_action :verify_authorized
  respond_to :html

  def cancel_account
    @user = current_user
    @cancel_account_form = CancelAccountForm.new
    authorize @user, :destroy?
  end

  def destroy
    authorize @user, :destroy?

    @cancel_account_form = CancelAccountForm.new(params[:cancel])
    if @user.valid_password? @cancel_account_form.password
      StandardDestroyer.new(StandardResponder.new(self,
                                                  redirect_path: new_user_session_path,
                                                  success_text: 'Your account has been deleted.')).destroy(@user)
    else
      flash[:error] = 'Password invalid.'
      render 'cancel_account'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
