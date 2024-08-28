require 'rails_helper'

RSpec.describe "borrowings/new", type: :view do
  before(:each) do
    assign(:borrowing, Borrowing.new(
      user: nil,
      book: nil,
      returned_at: nil
    ))
  end

  it "renders new borrowing form" do
    render

    assert_select "form[action=?][method=?]", borrowings_path, "post" do

      assert_select "input[name=?]", "borrowing[user_id]"

      assert_select "input[name=?]", "borrowing[book_id]"

      assert_select "input[name=?]", "borrowing[returned]"
    end
  end
end
