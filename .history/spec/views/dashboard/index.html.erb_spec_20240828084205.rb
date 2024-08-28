require 'rails_helper'

RSpec.describe "dashboard/index.html.erb", type: :view do
  let(:borrowing) { create_list(:borrowing, 2) }
  before(:each) do
    # Assuming the dashboard displays some metrics
    assign(:total_borrowed_books, 300)
    assign(:total_books, 200)
    assign(:books_due_today, borrowing)
    assign(:members_with_overdue_books, [])
  end

  it "renders the dashboard with key metrics" do
    render
    expect(rendered).to match(/Total Books:<\/strong> 200/)
    expect(rendered).to match(/Total Borrowed Books:<\/strong> 300/)
  end
end