class PetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  # metodos CRUD vem após linha 6

  def new?
    return true
  end

  def create?
    return true
  end

  def show?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def edit?
    update?
  end

  # Verifying if there's any request made by the current user for the current pet
  def show_message_link?
    Request.where(pet_id: record.id, user_id: user.id).present?
  end

  # Verifying if the current user is the owner of the pet to show all requests
  def list_requests?
    record.user.id == user.id
  end
end
