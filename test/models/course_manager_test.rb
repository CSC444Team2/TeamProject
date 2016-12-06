require 'test_helper'

class CourseManagerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @u1 = User.create(first_name: 'i', last_name: 'i', email: 'i@i.com', password:'1234567', password_confirmation:'1234567')
  	@u2 = User.create(first_name: 'i', last_name: 'i', email: 'ahh@ahh.com', password:'123ss4567', password_confirmation:'123ss4567')
  	
  	@gf1=GolfCourse.create(name: 'GF111', overview: 'Great course', address: '7859 Yonge Street, Thornhill, ON L3T 2C4', website: 'http://www.ladiesgolfclub.com/', contact_info: 'Anna')
	  @gf2=GolfCourse.create(name: 'Humber Valley 2', address: '40 Blah', website: 'http://www1.toronto.ca/wps/portal/contentonly?vgnextoid=5e1cd49024561410VgnVCM10000071d60f89RCRD', contact_info: 'Anna', overview: "Humber Valley'ses.")

  	@cg1 = CourseManager.new(golf_course_id: @gf1.id, manager_id: @u2.id)
  	@cg2 = CourseManager.new(golf_course_id: @gf2.id, manager_id: @u1.id)
  end

  test "CourseManager relation should have golf_course_id" do
  	@cg1.golf_course_id = nil
  	assert_not @cg1.valid?
  	@cg2.golf_course_id = nil
  	assert_not @cg2.valid?
  end

  test "CourseManager relation should have manager_id" do
  	@cg1.manager_id = nil
  	assert_not @cg1.valid?
  	@cg2.manager_id = nil
  	assert_not @cg2.valid?
  end

  test "Correct CourseManager relation should be valid" do
  	assert @cg1.valid?
  	assert @cg2.valid?
  end

  test "Correct CourseManager relation should save successfully" do
  	assert @cg1.new_record?
  	assert @cg2.new_record?
  	assert @cg1.save
  	assert @cg2.save
  end

  test "CourseManager should link correctly with golf courses" do
  	assert_not @gf1.got_manager?(@u2)
  	assert_not @gf2.got_manager?(@u1)
  	@cg1.save
  	assert @gf1.got_manager?(@u2)
  	@cg2.save
  	assert @gf2.got_manager?(@u1)
  end

  test "CourseManager should link correctly with users" do
  	assert_not @u2.dealt_a_course?(@gf1, 1)
  	assert_not @u1.dealt_a_course?(@gf2, 1)
  	@cg1.save
  	assert @u2.dealt_a_course?(@gf1, 1)
  	@cg2.save
  	assert @u1.dealt_a_course?(@gf2, 1)
  end

end
