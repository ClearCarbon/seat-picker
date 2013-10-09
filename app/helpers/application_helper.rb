module ApplicationHelper
  def admin?
    if signed_in?
      if current_user.email == 'admin@example.com'
        return true
      end
    end

    return false
  end
end
