# == Schema Information
#
# Table name: health_savings_accounts
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  account_number :string
#  routing_number :string
#  account_name   :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_health_savings_accounts_on_account_number  (account_number)
#  index_health_savings_accounts_on_user_id         (user_id)
#

class HealthSavingsAccount < ActiveRecord::Base
  belongs_to :user
  has_paper_trail versions: :paper_trail_versions

  validates :account_number, presence: true, uniqueness: true, length: {maximum: 20, minimum: 5}
  validates :routing_number, presence: true, uniqueness: true, length: {maximum: 20, minimum: 5}
  validates :user_id, presence: true, uniqueness: true
  validates :account_name, presence: true, uniqueness: true
end
