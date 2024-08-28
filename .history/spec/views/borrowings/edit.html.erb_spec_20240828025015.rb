require 'rails_helper'

RSpec.describe "borrowings/edit", type: :view do
  let(:borrowing) {
    Borrowing.create!(
      user: nil,
      book: nil,
      returned: nil
    )
  }

  before(:each) do
    assign(:borrowing, borrowing)
  end

  it "renders the edit borrowing form" do
    render

    assert_select "form[action=?][method=?]", borrowing_path(borrowing), "post" do

      assert_select "input[name=?]", "borrowing[user_id]"

      assert_select "input[name=?]", "borrowing[book_id]"

      assert_select "input[name=?]", "borrowing[returned]"
    end
  end
end
