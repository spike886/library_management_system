class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  ROLES = %w[librarian member].freeze

  validates :role, inclusion: { in: ROLES }


  has_many :borrowings

  def librarian?
    role == 'librarian'
  end

  def member?
    role == 'member'
  end
end
