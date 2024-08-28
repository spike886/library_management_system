require 'rails_helper'

RSpec.describe "books/edit", type: :view do
  let(:book) { create(:book) }

  before(:each) do
    assign(:book, book)
  end

  xit "renders the edit book form" do
    render

    assert_select "form[action=?][method=?]", book_path(book), "post" do
      assert_select "input[name=?]", "book[title]"
      assert_select "input[name=?]", "book[author]"
      assert_select "input[name=?]", "book[genre]"
      assert_select "input[name=?]", "book[isbn]"
      assert_select "input[name=?]", "book[total_copies]"
    end
  end
end