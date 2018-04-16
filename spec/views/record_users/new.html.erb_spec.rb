require 'rails_helper'

RSpec.describe "record_users/new", type: :view do
  before(:each) do
    assign(:record_user, RecordUser.new(
      :condition => 1,
      :rating => 1,
      :favorite => false
    ))
  end

  it "renders new record_user form" do
    render

    assert_select "form[action=?][method=?]", record_users_path, "post" do

      assert_select "input#record_user_condition[name=?]", "record_user[condition]"

      assert_select "input#record_user_rating[name=?]", "record_user[rating]"

      assert_select "input#record_user_favorite[name=?]", "record_user[favorite]"
    end
  end
end
