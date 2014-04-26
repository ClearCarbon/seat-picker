class UserPolicy < Struct.new(:user, :user)
  def update?
    user.admin?
  end

  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
