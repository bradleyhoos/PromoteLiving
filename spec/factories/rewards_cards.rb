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

require 'factory_girl'

FactoryGirl.define do
  factory :rewards_card do
    rewards_number { Faker::Business.credit_card_number }

    factory :rewards_card_with_user_and_retailer do
      user
      retailer
    end
  end

end
