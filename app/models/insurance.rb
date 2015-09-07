# == Schema Information
#
# Table name: insurances
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  first_name   :string
#  last_name    :string
#  enrollee_id  :string
#  group_number :string
#  issue_date   :date
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

  validates :first_name, presence: true, length: {maximum: 50, minimum: 2}
  validates :last_name, presence: true, length: {maximum: 100, minimum: 2}
  validates :enrollee_id, presence: true, uniqueness: true, length: {maximum: 20, minimum: 5}
  validates :group_number, presence: true, uniqueness: true, length: {maximum: 20, minimum: 5}
  validates :user_id, presence: true, uniqueness: true

  def full_name
    return if first_name.nil? || last_name.nil?
    first_name + " " + last_name
  end
end
