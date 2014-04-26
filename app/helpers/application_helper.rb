module ApplicationHelper
  def admin?
    if signed_in?
      return current_user.admin?
    end
  end
end
