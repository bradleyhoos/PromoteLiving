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
require 'rails_helper'

RSpec.describe Insurance, type: :model do
  let(:ins) { create(:insurance_with_user,
    # user_id: 1,
    first_name: "Scooby",
    last_name: "Doo",
    enrolee_id: "123456789ABC",
    group_number: "xyz123456")
  }

  it { should belong_to(:user) }
  it { should validate_uniqueness_of(:user_id) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:enrolee_id) }
  it { should validate_presence_of(:group_number) }

  describe 'valid Model' do
    it "should create insurance record" do
      expect(ins).to be_valid
    end

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
      ins.last_name="a"
      expect(ins).to_not be_valid
    end

    it "Last Name should not be to long" do
      ins.last_name="a" * 101
      expect(ins).to_not be_valid
    end

    it "Enrolee ID should be present" do
      ins.enrolee_id = "     "
      expect(ins).to_not be_valid
    end

    it "Enrolee ID should be long enough" do
      ins.enrolee_id = "aaaa"
      expect(ins).to_not be_valid
    end

    it "Enrolee ID should not be to long" do
      ins.enrolee_id = "a" * 21
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

end
