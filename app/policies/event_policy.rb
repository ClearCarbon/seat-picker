class EventPolicy < Struct.new(:current_user, :event)
  class Scope < Struct.new(:current_user, :event)
    def resolve
      Event.all
    end
  end

  def update?
    current_user.admin?
  end

  def create?
    current_user.admin?
  end

  def destroy?
    current_user.admin?
  end
end
