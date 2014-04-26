class SeatPolicy < Struct.new(:user, :seat)
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
