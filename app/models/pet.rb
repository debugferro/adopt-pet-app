class Pet < ApplicationRecord
  before_save :capitalize_inputs
  has_many :requests, dependent: :destroy
  has_one_attached :photo
  belongs_to :user
  attribute :adopted, default: false
  # geocoded_by :neighborhood
  # after_validation :geocode, if: :will_save_change_to_neighborhood?

  SPECIES = %w[Bird Cat Dog Fish Frog Hamster Lizard]
  SIZES = %w[Small Mid-Sized Big]
  AGES = %w[Puppy Juvenile Adult]

  validates :name, presence: true, allow_blank: false, length: { in: 2..20 }
  validates :photo, presence: true
  validates :found_date, presence: true
  validates :description, presence: true, length: { in: 70..255 }
  validates :species, presence: true, inclusion: { in: SPECIES }
  validates :size, presence: true, inclusion: { in: SIZES }
  validates :age, presence: true, inclusion: { in: AGES }
  validates :state, presence: true
  validates :city, presence: true

  def capitalize_inputs
    self.name = name.capitalize if name
    self.state = state.capitalize if state
    self.city = city.capitalize if city
  end
end
