require 'test_helper'

class InsuranceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
	@ins = Insurance.new(user_id: 1, first_name: "Scooby", last_name: "Doo", enrolee_id: "123456789ABC", group_number: "xyz123456")
  end
  
  test "should create insurance record" do
	assert @ins.valid?
	end
	# First_name tests
 test "First name should be present" do
    @ins.first_name = "     "
    assert_not @ins.valid?
  end
  
  test "First Name should be long enough" do
  @ins.first_name="a"
  assert_not @ins.valid?
  end
  
  test "First Name should not be to long" do
  @ins.first_name="a" * 51
  assert_not @ins.valid?
  end
  # LastName tests
   test "Last name should be present" do
    @ins.last_name = "     "
    assert_not @ins.valid?
  end
  
  test "Last Name should be long enough" do
  @ins.last_name="a"
  assert_not @ins.valid?
  end
  
  test "Last Name should not be to long" do
  @ins.last_name="a" * 101
  assert_not @ins.valid?
  end
  
  #Enrolee ID tests  
    test "Enrolee ID should be present" do
    @ins.enrolee_id = "     "
    assert_not @ins.valid?
  end
  
  test "Enrolee ID should be long enough" do
  @ins.enrolee_id="aaaa"
  assert_not @ins.valid?
  end
  
  test "Enrolee ID should not be to long" do
  @ins.enrolee_id="a" * 21
  assert_not @ins.valid?
  end
  
    #Group Number tests  
    test "Group Number should be present" do
    @ins.group_number = "     "
    assert_not @ins.valid?
  end
  
  test "Group Number should be long enough" do
  @ins.group_number="aaaa"
  assert_not @ins.valid?
  end
  
  test "Group Number  should not be to long" do
  @ins.group_number="a" * 21
  assert_not @ins.valid?
  end
  
end
