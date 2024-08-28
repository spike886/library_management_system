require 'rails_helper'

RSpec.describe "dashboard/index.html.erb", type: :view do
  before(:each) do
    # Assuming the dashboard displays some metrics
    assign(:total_users, 100)
    assign(:total_books, 200)
    assign(:total_borrowed_books, 300)
  end

  it "renders the dashboard with key metrics" do
    render
    expect(rendered).to match(/Total Books: 200/)
    expect(rendered).to match(/Total Borrowed Books: 300/)
    expect(rendered).to match(/Total Borrowed Books: 300/)
  end
end