require "rails_helper"

RSpec.describe RecordUsersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/record_users").to route_to("record_users#index")
    end

    it "routes to #new" do
      expect(:get => "/record_users/new").to route_to("record_users#new")
    end

    it "routes to #show" do
      expect(:get => "/record_users/1").to route_to("record_users#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/record_users/1/edit").to route_to("record_users#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/record_users").to route_to("record_users#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/record_users/1").to route_to("record_users#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/record_users/1").to route_to("record_users#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/record_users/1").to route_to("record_users#destroy", :id => "1")
    end

  end
end
