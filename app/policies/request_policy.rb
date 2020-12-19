class RequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    if record.user == user || record.pet.user == user
      true
    else
      false
    end
  end

  def view?
    create?
  end
end
