# == Schema Information
#
# Table name: insurances
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  enrollee_id  :string
#  group_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_insurances_on_user_id  (user_id)
#

require 'factory_girl'

FactoryGirl.define do
  factory :insurance do
    enrollee_id SecureRandom.hex(8)
    group_number SecureRandom.hex(8)

    factory :insurance_with_user do
      user
    end
  end

end
