require 'rails_helper'

RSpec.describe "record_users/index", type: :view do
  before(:each) do
    assign(:record_users, [
      RecordUser.create!(
        :condition => 2,
        :rating => 3,
        :favorite => false
      ),
      RecordUser.create!(
        :condition => 2,
        :rating => 3,
        :favorite => false
      )
    ])
  end

  it "renders a list of record_users" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
