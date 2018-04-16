require 'rails_helper'

RSpec.describe "record_users/show", type: :view do
  before(:each) do
    @record_user = assign(:record_user, RecordUser.create!(
      :condition => 2,
      :rating => 3,
      :favorite => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/false/)
  end
end
