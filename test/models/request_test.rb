require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@u1 = User.create(first_name: 'b', last_name: 'b', email: 'b1@b1.com', 
	password:'1234567', password_confirmation:'1234567')
  	@u2 = User.create(first_name: 'b', last_name: 'b', email: 'b2@b2.com', 
	password:'1234567', password_confirmation:'1234567')
  	@u3 = User.create(first_name: 'b', last_name: 'b', email: 'b3@b3.com', 
  	password:'1234567', password_confirmation:'1234567')
  	@t1 = Tournament.create(name: "test player group")
  	@t1 = Tournament.find_by(name: "test player group")

  	@r1 = Request.new(sender_id: @u1.id, receiver_id: @u2.id)
  	@r2 = Request.new(sender_id: @u2.id, receiver_id: @u3.id)
  	@r3 = Request.new(sender_id: @u2.id, receiver_id: @u1.id)
  	@r4 = Request.new(sender_id: @u3.id, receiver_id: @u2.id)
  end

  test "Correct requests should be valid" do
  	assert @r1.valid?
  	assert @r2.valid?
  	assert @r3.valid?
  	assert @r4.valid?
  end

  test "Correct request should save successfully"do
  	assert @r1.save
  	assert @r2.save
  	assert @r3.save
  	assert @r4.save
  end

  test "Requests should have sender_id"  do
  	@r1.sender_id = nil
  	assert_not @r1.valid?
  	@r2.sender_id = nil
  	assert_not @r2.valid?
  	@r3.sender_id = nil
  	assert_not @r3.valid?
  	@r4.sender_id = nil
  	assert_not @r4.valid?
  end

  test "Requests should have receiver_id"  do
  	@r1.receiver_id = nil
  	assert_not @r1.valid?
  	@r2.receiver_id = nil
  	assert_not @r2.valid?
  	@r3.receiver_id = nil
  	assert_not @r3.valid?
  	@r4.receiver_id = nil
  	assert_not @r4.valid?
  end

  test "SHOULD allow duplicate requests" do
  	@r1.save
  	@new_req = Request.new(sender_id: @u1.id, receiver_id: @u2.id)
  	assert @new_req.valid?
  	assert @new_req.new_record?
  	@new_req.save
  	assert_not @new_req.new_record?
  end

  test "Allow request message to be 200 chars" do
  	@message = "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
  	@new_req = Request.new(sender_id: @u1.id, receiver_id: @u2.id, message: @message)
  	assert @new_req.valid?
  	@new_req.save
  	assert_not @new_req.new_record?
  end

  test "Request message should not be too long" do
  	@message = "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890asdfasdfasdfasdf"
  	@new_req = Request.new(sender_id: @u1.id, receiver_id: @u2.id, message: @message)
  end
end
