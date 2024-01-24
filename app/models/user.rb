class User < ApplicationRecord
  has_many :foods
  has_many :recipes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  validates :name, presence: true

  def is?(requested_role)
    role == requested_role.to_s
  end
end
