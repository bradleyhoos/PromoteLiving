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

require 'rails_helper'

RSpec.describe Insurance, type: :model do
  let(:ins) { create(:insurance_with_user, enrollee_id: "123456789ABC",
    group_number: "xyz123456")
  }

  it { should belong_to(:user) }
  it { should validate_uniqueness_of(:user_id) }
  it { should validate_presence_of(:enrollee_id) }
  it { should validate_presence_of(:group_number) }

  describe 'valid Insurance Model' do
    it "should create insurance record" do
      expect(ins).to be_valid
    end

    it "Enrolee ID should be present" do
      ins.enrollee_id = "     "
      expect(ins).to_not be_valid
    end

    it "Enrolee ID should be long enough" do
      ins.enrollee_id = "aaaa"
      expect(ins).to_not be_valid
    end

    it "Enrolee ID should not be to long" do
      ins.enrollee_id = "a" * 21
      expect(ins).to_not be_valid
    end

    it "Group Number should be present" do
      ins.group_number = "     "
      expect(ins).to_not be_valid
    end

    it "Group Number should be long enough" do
      ins.group_number = "aaaa"
      expect(ins).to_not be_valid
    end

    it "Group Number  should not be to long" do
      ins.group_number = "a" * 21
      expect(ins).to_not be_valid
    end
  end

  describe 'first_name & last_name' do
    it "First name should be present" do
      ins.first_name = "     "
      expect(ins).to_not be_valid
    end

    it "First Name should be long enough" do
      ins.first_name = "a"
      expect(ins).to_not be_valid
    end

    it "First Name should not be to long" do
      ins.first_name = "a" * 51
      expect(ins).to_not be_valid
    end

    it "Last name should be present" do
      ins.last_name = "     "
      expect(ins).to_not be_valid
    end

    it "Last Name should be long enough" do
      ins.last_name = "a"
      expect(ins).to_not be_valid
    end

    it "Last Name should not be to long" do
      ins.last_name = "a" * 101
      expect(ins).to_not be_valid
    end
  end

end
