class UserPolicy < Struct.new(:current_user, :user)
  def update?
    current_user.admin?
  end

  def create?
    current_user.admin?
  end

  def destroy?
    current_user.admin?
  end

  def promote?
    if(current_user.id == user.id)
      return false
    end

    current_user.admin?
  end
end
