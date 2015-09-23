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

require 'factory_girl'

FactoryGirl.define do
  factory :retailer do
    name { Faker::Company.name }

    factory :retailer_with_cards do
      rewards_card
    end
  end

end
