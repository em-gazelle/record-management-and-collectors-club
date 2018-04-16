require 'rails_helper'

RSpec.describe "RecordUsers", type: :request do
  describe "GET /record_users" do
    it "works! (now write some real specs)" do
      get record_users_path
      expect(response).to have_http_status(200)
    end
  end
end
