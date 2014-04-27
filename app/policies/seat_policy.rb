class SeatPolicy < Struct.new(:user, :seat)

  class Scope < Struct.new(:current_user, :user)
    def resolve
      user.all
    end
  end

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
