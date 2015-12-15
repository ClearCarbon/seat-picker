module ApplicationHelper
  def admin?
    return current_user.admin? if signed_in?
  end
end
