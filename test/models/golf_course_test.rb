require 'test_helper'

class GolfCourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
	 @gf1=GolfCourse.new(name: 'Ladies Golf Club of Toronto', overview: 'Great course', address: '7859 Yonge Street, Thornhill, ON L3T 2C4', website: 'http://www.ladiesgolfclub.com/', contact_info: 'Anna')
	 @gf2=GolfCourse.new(name: 'Humber Valley Golf Course', address: '40 Beattie Avenue', website: 'http://www1.toronto.ca/wps/portal/contentonly?vgnextoid=5e1cd49024561410VgnVCM10000071d60f89RCRD', contact_info: 'Anna', overview: "Humber Valley's par 70 course challenges golfers with its combination of links and valley land holes.")
  end

  test "Correct golf courses should be valid" do
  	assert @gf1.valid?
  	assert @gf2.valid?
  end

  test "Correct golf courses should save successfully" do
  	assert @gf1.save
  	assert @gf2.save
  end

  test "Golf courses should have names" do
  	@gf1.name = nil
  	assert_not @gf1.valid?
  	@gf2.name = nil
  	assert_not @gf2.valid?
  end

  test "Golf courses should have address" do
  	@gf1.address = nil
  	assert_not @gf1.valid?
  	@gf2.address = nil
  	assert_not @gf2.valid?
  end

  test "Golf courses could omit overview" do
  	@gf1.overview = nil
  	assert @gf1.valid?
  	@gf2.overview = nil
  	assert @gf2.valid?
  end

  test "Golf courses without overview can save" do
  	@gf1.overview = nil
  	assert @gf1.save
  	@gf2.overview = nil
  	assert @gf2.save
  end

  test "Golf courses should set relevant tournament to nil when deleted" do
  	@t1 = Tournament.create(name: "new tour", golf_course_id: @gf1.id)
  	@t2 = Tournament.create(name: "new tour2", golf_course_id: @gf1.id)
  	assert @t1.golf_course_id==@gf1.id
  	assert @t2.golf_course_id==@gf2.id

  	@gf1.destroy
  	@t1 = Tournament.find(@t1.id)
  	assert @t1.golf_course_id.nil?

  	@gf2.destroy
  	@t2 = Tournament.find(@t2.id)
  	assert @t2.golf_course_id.nil?
  end
  # Note: Testing about other relations are included in tests for corresponding relation models & integration tests
end
