class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true 
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  # validates :password, presence: true, if: -> { new_record? }
  # validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true

  has_many :reservations, dependent: :destroy
end
