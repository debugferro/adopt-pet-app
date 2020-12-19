class Request < ApplicationRecord
  belongs_to :pet
  belongs_to :user
  has_many :messages
  before_validation :verify_creator
  attribute :finished, default: false

  message = "Sorry, it is not allowed to create two adoption requests! :("
  validates_uniqueness_of :user_id, scope: :pet_id, message: message
  validates :finished, default: false

  private

  def verify_creator
    if self.user.id == self.pet.user.id
      errors[:base] << "Sorry, you can't create a request for your own pet! :("
      false
    else
      true
    end
  end
end
