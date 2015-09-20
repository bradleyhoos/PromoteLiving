# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  preferred_name         :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  rolify
  has_paper_trail versions: :paper_trail_versions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :lockable, :timeoutable

  validates :password, presence: true, on: :create, length: { within: 6..40 }
  validates :email, presence: true, uniqueness: true,
            format: {
              with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
            }
  validates :first_name, presence: true, length: {maximum: 50, minimum: 2}
  validates :last_name, presence: true, length: {maximum: 100, minimum: 2}

  # has_one :account, dependent: :destroy
  has_one :insurance, dependent: :destroy

  # accepts_nested_attributes_for :insurance_policy

  def full_name
    return if first_name.nil? || last_name.nil?
    first_name + " " + last_name
  end

  def insurance_policy
    Insurance.find_by(user_id: self.id)
  end

end
