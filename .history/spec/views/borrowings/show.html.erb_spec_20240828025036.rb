require 'rails_helper'

RSpec.describe "borrowings/show", type: :view do
  before(:each) do
    assign(:borrowing, Borrowing.create!(
      user: nil,
      book: nil,
      returned: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
