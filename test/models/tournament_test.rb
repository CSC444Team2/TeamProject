require 'test_helper'

class TournamentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@t1 = t4=Tournament.create(name: 'hello5', is_private: 0, location: 'Toronto', date: DateTime.new(2016, 12, 12, 12, 0, 0), contact_email: 'abc@abc.com', contact_name: 'corey')
  end

  test "valid tournaments should be valid" do
  	assert @t1.valid?
  end

  test "name should present"  do
  	@t1.name=nil
  	assert_not @t1.valid?
  end

  test "name should not be too long" do
  	@t1.name = "12345678901234567890123456789012345678901234567890aasdf"
  	assert_not @t1.valid?
  end

  test "name could be 50 characters long" do
  	@t1.name = "12345678901234567890123456789012345678901234567890"
  	assert @t1.valid?
  end

  #***Note: relation testings are included in tests for models for relation & integration tests
  
end
