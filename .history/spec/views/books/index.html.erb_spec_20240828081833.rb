require 'rails_helper'

RSpec.describe "books/index", type: :view do
  before(:each) do
    assign(:books, [
      create(:book, title: "Title1", author: "Author1", genre: "Genre1", isbn: "Isbn1", total_copies: 2),
      create(:book, title: "Title2", author: "Author2", genre: "Genre2", isbn: "Isbn2", total_copies: 2)
    ])
  end

  it "renders a list of books" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Title1".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Author1".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Genre1".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Isbn1".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Title2".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Author2".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Genre2".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Isbn2".to_s), count: 1
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end