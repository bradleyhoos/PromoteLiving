require 'rails_helper'

RSpec.describe RewardsCardsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/rewards_cards").to route_to("rewards_cards#index")
    end

    it "routes to #rewards_card_chooser" do
      expect(get: "/rewards_card_chooser").to route_to("rewards_cards#rewards_card_chooser")
    end

    it "routes to #new" do
      expect(get: "/rewards_cards/new").to route_to("rewards_cards#new")
    end

    it "routes to #show" do
      expect(get: "/rewards_cards/1").to route_to("rewards_cards#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/rewards_cards/1/edit").to route_to("rewards_cards#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/rewards_cards").to route_to("rewards_cards#create")
    end

    it "routes to #update" do
      expect(put: "/rewards_cards/1").to route_to("rewards_cards#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/rewards_cards/1").to route_to("rewards_cards#destroy", id: "1")
    end

  end
end
