class Admin::AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_admin!

  private

    def verify_admin!
      render :file => 'public/404.html',
        :status => :not_found, :layout => false unless current_user.admin?
    end

end
