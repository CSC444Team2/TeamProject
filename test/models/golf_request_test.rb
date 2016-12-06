require 'test_helper'

class GolfRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	 @u1 = User.create(first_name: 'i', last_name: 'i', email: 'iasd@baai.com', password:'1234567', password_confirmation:'1234567')
     @u2 = User.create(first_name: "ExampleFirst", last_name: "ExampleLast", email: "useaaaar@examplasssdse.com", password: "foobar", password_confirmation: "foobar")
     @u3 = User.create(first_name: 'i', last_name: 'i', email: 'iasdf@i.com', password:'1234567', password_confirmation:'1234567')
     @u4 = User.create(first_name: "ExampleFirst", last_name: "ExaaaasdmpleLast", email: "user@ssssexample.com", password: "foobar", password_confirmation: "foobar")

	 @gf1=GolfCourse.create(name: 'Ladies Golf Club of Toronto', overview: 'Great course', address: '7859 Yonge Street, Thornhill, ON L3T 2C4', website: 'http://www.ladiesgolfclub.com/', contact_info: 'Anna')
	 @gf2=GolfCourse.create(name: 'Humber Valley Golf Course', address: '40 Beattie Avenue', website: 'http://www1.toronto.ca/wps/portal/contentonly?vgnextoid=5e1cd49024561410VgnVCM10000071d60f89RCRD', contact_info: 'Anna', overview: "Humber Valley's par 70 course challenges golfers with its combination of links and valley land holes.")
  	 @u1.deal_course(@gf1, 0)
  	 @u2.deal_course(@gf1, 0)

  	 @admin_req1 = GolfRequest.new(sender_id: @u3.id, receiver_id: @gf1.id, golf_request_type: 0)
  	 @admin_req2 = GolfRequest.new(sender_id: @u4.id, receiver_id: @gf2.id, golf_request_type: 1)

  	 @csr_req1 = GolfRequest.new(sender_id: @u2.id, receiver_id: @gf1.id, golf_request_type: 0)
  	 @csr_req2 = GolfRequest.new(sender_id: @u3.id, receiver_id: @gf1.id, golf_request_type: 1)
  end

  test "Correct request should be valid"do
  	assert @admin_req1.valid?
  	assert @admin_req2.valid?
  	assert @csr_req1.valid?
  	assert @csr_req2.valid?
  end

  



end
