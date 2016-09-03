class EventPolicy < Struct.new(:user, :event)
  
  class Scope < Struct.new(:user, :event)
    def resolve
      event.all
    end
  end
  
  def read?
    true
  end
  
  def pick?
    true
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
