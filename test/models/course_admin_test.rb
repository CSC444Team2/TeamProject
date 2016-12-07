require 'test_helper'

class CourseAdminTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @gf1=GolfCourse.create(name: 'GF111', overview: 'Great course', address: '7859 Yonge Street, Thornhill, ON L3T 2C4', website: 'http://www.ladiesgolfclub.com/', contact_info: 'Anna')
	@gf2=GolfCourse.create(name: 'GolfCourse 2', address: '40 Blah', website: 'http://www1.toronto.ca/wps/portal/contentonly?vgnextoid=5e1cd49024561410VgnVCM10000071d60f89RCRD', contact_info: 'Anna', overview: "Humber Valley's par 70 course challenges golfers with its combination of links and valley land holes.")
  
    @u1 = User.create(first_name: 'i', last_name: 'i', email: 'i@i.com', password:'1234567', password_confirmation:'1234567')
  	@u2 = User.create(first_name: 'i', last_name: 'i', email: 'ahh@ahh.com', password:'123ss4567', password_confirmation:'123ss4567')
  	@ca1 = CourseAdmin.new(golf_course_id: @gf1.id, admin_id: @u2.id)
  	@ca2 = CourseAdmin.new(golf_course_id: @gf2.id, admin_id: @u1.id)
  end

  test "CourseAdmin relation should be valid" do
  	assert @ca1.valid?
  	assert @ca2.valid?
  end

  test "CourseAdmin relation should save successfully" do
  	assert @ca1.new_record?
  	assert @ca2.new_record?
  	assert @ca1.save
  	assert @ca2.save
  end

  test "CourseAdmin relation should have golf_course_id" do
  	@ca1.golf_course_id = nil
  	assert_not @ca1.valid?
  	@ca2.golf_course_id = nil
  	assert_not @ca2.valid?
  end

  test "CourseAdmin relation should have admin_id" do
  	@ca1.admin_id = nil
  	assert_not @ca1.valid?
  	@ca2.admin_id = nil
  	assert_not @ca2.valid?
  end

  test "CourseAdmin should link correctly with golf courses" do
  	assert_not @gf1.got_admin?(@u2)
  	assert_not @gf2.got_admin?(@u1)
  	@ca1.save
  	assert @gf1.got_admin?(@u2)
  	@ca2.save
  	assert @gf2.got_admin?(@u1)
  end

  test "CourseAdmin should link correctly with users" do
  	assert_not @u2.dealt_a_course?(@gf1, 0)
  	assert_not @u1.dealt_a_course?(@gf2, 0)
  	@ca1.save
  	assert @u2.dealt_a_course?(@gf1, 0)
  	@ca2.save
  	assert @u1.dealt_a_course?(@gf2, 0)
  end

end
