require 'rails_helper'

RSpec.describe "borrowings/index", type: :view do
  before(:each) do
    assign(:borrowings, [
      Borrowing.create!(
        user: nil,
        book: nil,
        returned_at: nil
      ),
      Borrowing.create!(
        user: nil,
        book: nil,
        returned_at: nil
      )
    ])
  end

  it "renders a list of borrowings" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
  end
end
