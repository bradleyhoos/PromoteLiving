# == Schema Information
#
# Table name: retailers
#
#  id               :integer          not null, primary key
#  rewards_cards_id :integer
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_retailers_on_rewards_cards_id  (rewards_cards_id)
#

require 'rails_helper'

RSpec.describe Retailer, type: :model do
  let(:retailer) { create(:retailer) }

  it { should have_many(:rewards_cards) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  describe 'valid Retailer Model' do
    it "should create Retailer record" do
      expect(retailer).to be_valid
    end
  end

end
