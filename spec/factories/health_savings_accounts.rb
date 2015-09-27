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

require 'factory_girl'

FactoryGirl.define do
  factory :health_savings_account do
    account_number { Faker::Business.credit_card_number }
    routing_number { Faker::Business.credit_card_number }
    account_name   { Faker::Name.name }

    factory :hsa_with_user do
      user
    end
  end

end
