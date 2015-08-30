# == Schema Information
#
# Table name: insurances
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  first_name   :string
#  last_name    :string
#  enrolee_id   :string
#  group_number :string
#  insurer_id   :integer
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
    first_name 'John'
    last_name 'Doe'
    enrolee_id SecureRandom.hex(1)
    group_number SecureRandom.hex(1)
    insurer_id SecureRandom.hex(1)

    factory :insurance_with_user do
      user
    end
  end
end
