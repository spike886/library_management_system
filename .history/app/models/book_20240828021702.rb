class Book < ApplicationRecord
  has_many :borrowings

  def available?
    total_copies > borrowings.where(returned: false).count
  end
end
