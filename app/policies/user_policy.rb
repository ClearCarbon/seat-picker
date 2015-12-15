class UserPolicy < Struct.new(:current_user, :user)
  class Scope < Struct.new(:current_user, :user)
    def resolve
      if current_user.admin?
        user.all
      else
        user.where(id: current_user.id)
      end
    end
  end

  def update?
    current_user.admin?
  end

  def create?
    current_user.admin?
  end

  def destroy?
    current_user.admin? || current_user.id == user.id
  end

  def promote?
    return false if current_user.id == user.id

    current_user.admin?
  end
end
