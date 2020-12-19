class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :photo
  has_many :requests, dependent: :destroy
  has_many :messages, through: :requests
  has_many :pets, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validating first name presence, format and length
  validates :first_name,
            presence: true,
            format: { with: /[a-z\s.-]/i },
            length: { minimum: 3, maximum: 15 }

  # Validating last name presence, format and length
  validates :last_name,
            presence: true,
            format: { with: /[a-z\s.-]/i },
            length: { minimum: 3, maximum: 15 }

  validates :birth_date, presence: true
  validates :about_me, presence: true, length: { minimum: 40, maximum: 255 }
end
