require 'rails_helper'

RSpec.describe "books/show", type: :view do
  before(:each) do
    assign(:book, Book.create!(
      title: "Title",
      author: "Author",
      genre: "Genre",
      isbn: "Isbn",
      total_copies: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Author/)
    expect(rendered).to match(/Genre/)
    expect(rendered).to match(/Isbn/)
    expect(rendered).to match(/2/)
  end
end
