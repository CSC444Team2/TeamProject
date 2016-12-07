
require 'test_helper'

class UserInvolveGolfCourseTest < ActiveSupport::TestCase
    def setup do
      @u1=User.create(first_name: 'as', last_name: 'Blah', email: 'join@join.com', password:'1234567', password_confirmation:'1234567')
      @u2=User.create(first_name: 'aasdf', last_name: 'Blah2', email: 'b@b.com', password:'1234567', password_confirmation:'1234567')
      @gf1=GolfCourse.create(name: 'mygf')
      @gf2=GolfCourse.create(name: 'mygf2:)')
    end

    test "User admin course should work" do
      assert_not @u1.dealt_a_course?(@gf1, 0)
      assert_not @u1.dealt_a_course?(@gf2, 1)
      @u1.deal_course(gf1, 0)
      assert @u1.dealt_a_course?(@gf1, 0)
      assert_not @u1.dealt_a_course?(@gf2, 1)
      @u1.deal_course(gf2, 0)
      assert @u1.dealt_a_course?(@gf1, 0)
      assert @u1.dealt_a_course?(@gf2, 1)
      assert_not @u2.dealt_a_course(@gf1, 0)
      assert_not @u2.dealt_a_course(@gf2, 0)
      assert_not @u2.dealt_a_course(@gf1, 1)
      assert_not @u2.dealt_a_course(@gf2, 1)
    end

    test "User manage course should work" do
      assert_not @u1.dealt_a_course?(@gf1, 0)
      assert_not @u1.dealt_a_course?(@gf2, 1)
      @u1.deal_course(gf1, 1)
      assert @u1.dealt_a_course?(@gf1, 1)
      assert_not @u1.dealt_a_course?(@gf2, 1)
      @u1.deal_course(gf2, 0)
      assert @u1.dealt_a_course?(@gf1, 0)
      assert @u1.dealt_a_course?(@gf2, 1)
      assert_not @u2.dealt_a_course(@gf1, 0)
      assert_not @u2.dealt_a_course(@gf2, 0)
      assert_not @u2.dealt_a_course(@gf1, 1)
      assert_not @u2.dealt_a_course(@gf2, 1)
    end

    test "User stop admin course should work" do
      @u1.dealt_a_course(@gf1, 0)
      assert @u1.dealt_a_course?(@gf1, 0)
      @u1.not_deal_course(@gf1, 0)
      assert_not @u1.dealt_a_course?(@gf1, 0)

      @u1.dealt_a_course(@gf2, 0)
      assert @u1.dealt_a_course?(@gf2, 0)
      @u1.not_deal_course(@gf2, 0)
      assert_not @u1.dealt_a_course?(@gf2, 0)
    end

    test "User stop manage course should work" do
      @u1.dealt_a_course(@gf1, 1)
      assert @u1.dealt_a_course?(@gf1, 1)
      @u1.not_deal_course(@gf1, 1)
      assert_not @u1.dealt_a_course?(@gf1, 1)

      @u1.dealt_a_course(@gf2, 1)
      assert @u1.dealt_a_course?(@gf2, 1)
      @u1.not_deal_course(@gf2, 1)
      assert_not @u1.dealt_a_course?(@gf2, 1)
    end

    test "should not fail if not deal is called when user do not deal course" do
      @u1.deal_course(@gf1, 1)
      @u1.not_deal_course(@gf1, 0)
      @u1.not_deal_course(@gf1, 0)
      @u1.not_deal_course(@gf1, 0)
      assert_not @u1.dealt_a_course?(@gf1, 0)
      assert @u1.dealt_a_course?(@gf1, 1)

      @u2.deal_course(@gf2, 0)
      @u2.not_deal_course(@gf2, 1)
      @u2.not_deal_course(@gf2, 1)
      @u2.not_deal_course(@gf2, 1)
      assert_not @u2.dealt_a_course?(@gf2, 1)
      assert @u2.dealt_a_course?(@gf2, 0)
    end
end

