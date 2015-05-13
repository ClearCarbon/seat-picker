class Admin::AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_admin!

  private

    def verify_admin!
      raise AbstractController::ActionNotFound unless current_user.admin?
    end

end
