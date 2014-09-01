class SeatPolicy < Struct.new(:user, :seat)

  class Scope < Struct.new(:user, :seat)
    def resolve
      seat.all
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

  def pick?
    if seat.reserved?
        return false
    else
      return seat.user.nil?
    end
  end

  def give_up?
    seat.user.id == user.id
  end
end
