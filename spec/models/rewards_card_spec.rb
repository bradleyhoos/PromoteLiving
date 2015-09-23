# == Schema Information
#
# Table name: rewards_cards
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  retailer_id    :integer
#  rewards_number :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_rewards_cards_on_retailer_id  (retailer_id)
#  index_rewards_cards_on_user_id      (user_id)
#

require 'rails_helper'

RSpec.describe RewardsCard, type: :model do
  let(:card) { create(:rewards_card) }

  it { should belong_to(:user) }
  it { should belong_to(:retailer) }
  it { should validate_presence_of(:rewards_number) }
  it { should validate_uniqueness_of(:rewards_number) }

  describe 'valid RewardsCard Model' do
    it "should create RewardsCard record" do
      expect(card).to be_valid
    end
  end

end
