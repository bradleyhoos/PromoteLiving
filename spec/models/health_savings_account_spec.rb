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

require 'rails_helper'

RSpec.describe HealthSavingsAccount, type: :model do
  let(:hsa) { create(:hsa_with_user) }

  it { should belong_to(:user) }
  it { should validate_presence_of(:account_number) }
  it { should validate_uniqueness_of(:account_number) }
  it { should validate_presence_of(:routing_number) }
  it { should validate_uniqueness_of(:routing_number) }
  it { should validate_presence_of(:account_name) }

  describe 'valid HealthSavingsAccount Model' do
    it "should create HealthSavingsAccount record" do
      expect(hsa).to be_valid
    end
  end

end
