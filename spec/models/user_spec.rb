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

require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }
  let(:ins) { create(:insurance, user_id: user.id) }

  # it { should validate_presence_of(:first_name) }
  # it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email) }
  it { should_not allow_value('blah').for(:email) }
  it { should allow_value('bigballscaptain@testicles.me').for(:email) }
  it { should have_one(:insurance).dependent(:destroy) }
  # it { should have_one(:account).dependent(:destroy) }
  #
  it { should have_many(:rewards_cards).dependent(:delete_all) }
  it { should have_one(:health_savings_account).dependent(:destroy) }

  it { should respond_to(:preferred_name) }
  it { should respond_to(:full_name) }

  describe 'valid Model' do
    it 'should be an instance of User Model' do
      expect(user).to be_an_instance_of(User)
    end

    it 'should have a password length btwn 6..40' do
      expect(user.password.length).to be > 6
      expect(user.password.length).to be < 40
    end
  end

  describe 'first_name & last_name fails correctly' do
    it "First name should be present" do
      user.first_name = "     "
      expect(user).to_not be_valid
    end

    it "First Name should be long enough" do
      user.first_name = "a"
      expect(user).to_not be_valid
    end

    it "First Name should not be to long" do
      user.first_name = "a" * 51
      expect(user).to_not be_valid
    end

    it "Last name should be present" do
      user.last_name = "     "
      expect(user).to_not be_valid
    end

    it "Last Name should be long enough" do
      user.last_name = "a"
      expect(user).to_not be_valid
    end

    it "Last Name should not be to long" do
      user.last_name = "a" * 101
      expect(user).to_not be_valid
    end
  end

  describe '#insurance_policy' do
    it 'should return the users insurance_policy' do
      ins.reload
      expect(user.insurance_policy).to eq(ins)
    end

    it 'should return nil if the there is no policy yet' do
      user2 = create(:user)
      expect(user2.insurance_policy).to eq(nil)
    end
  end

  describe 'roles' do
    it 'add_role :admin method should work' do
      user.add_role :admin
      expect(user.has_role?(:admin)).to be(true)
    end
  end

end
