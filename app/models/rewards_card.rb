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

class RewardsCard < ActiveRecord::Base
  belongs_to :user
  belongs_to :retailer
  has_paper_trail versions: :paper_trail_versions
  validates :rewards_number, presence: true, uniqueness: true
end
