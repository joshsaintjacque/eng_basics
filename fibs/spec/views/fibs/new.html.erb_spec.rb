require 'rails_helper'

RSpec.describe "fibs/new", type: :view do
  before(:each) do
    assign(:fib, Fib.new())
  end

  it "renders new fib form" do
    render

    assert_select "form[action=?][method=?]", fibs_path, "post" do
    end
  end
end
