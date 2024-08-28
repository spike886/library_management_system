class Book < ApplicationRecord
  has_many :borrowings

  def available?
    total_copies > borrowings.where(returned_on: nil).count
  end
end
