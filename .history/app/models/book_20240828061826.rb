class Book < ApplicationRecord
  has_many :borrowings
  require 'pundit/rspec'

  def available?
    available_copies > 0
  end

  def available_copies
    total_copies - borrowings.where(returned_at: nil).count
  end
end
