module ApplicationHelper
  def admin?
    if signed_in?
      admin_email = Rails.application.config.admin_email
      if current_user.email == admin_email
        return true
      end
    end

    return false
  end
end
