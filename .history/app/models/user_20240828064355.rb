class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[librarian member].freeze

  validates :role, inclusion: { in: ROLES }
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :borrowings
  has_many :books, through: :borrowings

  def librarian?
    role == 'librarian'
  end

  def member?
    role == 'member'
  end
end
