require 'rails_helper'

RSpec.describe "dashboard/index.html.erb", type: :view do
  before(:each) do
    # Assuming the dashboard displays some metrics
    assign(:total_users, 100)
    assign(:total_books, 200)
    assign(:total_borrowings, 300)
  end

  it "renders the dashboard with key metrics" do
    render
    expect(rendered).to match(/Total Users: 100/)
    expect(rendered).to match(/Total Books: 200/)
    expect(rendered).to match(/Total Borrowings: 300/)
  end
end