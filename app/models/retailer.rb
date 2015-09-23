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

class Retailer < ActiveRecord::Base
  has_many :rewards_cards
  # has_many :images
  # has_many :locations
  has_paper_trail versions: :paper_trail_versions
  validates :name, presence: true, uniqueness: true
end
