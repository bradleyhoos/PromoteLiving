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

class Insurance < ActiveRecord::Base
  belongs_to :user
  has_paper_trail versions: :paper_trail_versions

  validates :enrollee_id, presence: true, uniqueness: true, length: {maximum: 20, minimum: 5}
  validates :group_number, presence: true, uniqueness: true, length: {maximum: 20, minimum: 5}
  validates :user_id, presence: true, uniqueness: true
end
