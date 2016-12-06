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

  test "tournament name should present"  do
  	@t1.name=nil
  	assert_not @t1.valid?
  end

  test "tournament name should not be too long" do
  	@t1.name = "12345678901234567890123456789012345678901234567890aasdf"
  	assert_not @t1.valid?
  end

  test "tournament name could be 50 characters long" do
  	@t1.name = "12345678901234567890123456789012345678901234567890"
  	assert @t1.valid?
    assert @t1.save
  end

  test "tournament can omit location" do
    @t1.location = nil
    assert @t1.valid?
    assert @t1.save
  end

  test "tournament can omit date" do
    @t1.date = nil
    assert @t1.valid?
    assert @t1.save
  end

  test "tournament can omit contact_email" do
    @t1.contact_email = nil
    assert @t1.valid?
    assert @t1.save
  end

  test "tournament can omit contact_name" do
    @t1.contact_name = nil
    assert @t1.valid?
    assert @t1.save
  end
 
  test "normal tournament descriptions should save" do
    @t1.description = "Welcome to our tournament!"
    assert @t1.valid?
    assert @t1.save
  end

  test "tournament description can be 300 chars long" do
    @t1.description = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
    assert @t1.valid?
    assert @t1.save
  end

  test "tournament description can not be more than 300 chars long" do
    @t1.description = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890A"
    assert_not @t1.valid?
  end

  test "tournament can be private or public" do
    @t1.is_private = 0
    assert @t1.valid?
    assert @t1.save
    @t1.is_private = 1
    assert @t1.valid?
    assert @t1.save
  end
  
  #***Note: relation testings are included in tests for models for relation & integration tests
  
end
