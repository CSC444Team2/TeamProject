require 'test_helper'

class PlayergroupTest < ActiveSupport::TestCase
  def setup
  	@u1 = User.create(first_name: 'b', last_name: 'b', email: 'b1@b1.com', 
	password:'1234567', password_confirmation:'1234567')
  	@u2 = User.create(first_name: 'b', last_name: 'b', email: 'b2@b2.com', 
	password:'1234567', password_confirmation:'1234567')
  	@u3 = User.create(first_name: 'b', last_name: 'b', email: 'b3@b3.com', 
  	password:'1234567', password_confirmation:'1234567')
  	@u4 = User.create(first_name: 'b', last_name: 'b', email: 'b4@b4.com', 
  	password:'1234567', password_confirmation:'1234567')
  	@u5 = User.create(first_name: 'b', last_name: 'b', email: 'b5@b5.com', 
  	password:'1234567', password_confirmation:'1234567')
  	@t1 = Tournament.create(name: "test player group")
  	@t1 = Tournament.find_by(name: "test player group")
  end

  test "should not save without id present" do
  	@pg1 = Playergroup.new
  	@pg1.save
  	assert @pg1.new_record?
  end
  
  test "normal function: correctly adds member to playergroup" do
  	@pg1 = Playergroup.new(tournament_id: @t1.id)
  	@pg1.add_member(@u1)
  	@pg1.add_member(@u2)
  	@pg1.add_member(@u3)
  
    puts @pg1
    puts @u1
  	puts @pg1.has_member?(@u1)
  	assert @pg1.has_member?(@u1)
  	assert @pg1.has_member?(@u2)
  	assert @pg1.has_member?(@u3)
  	assert_not @pg1.has_member?(@u4)
  	assert_not @pg1.has_member?(@u5)

  	@pg1.save
  	assert_not @pg1.new_record?
  end
  test "normal function: correctly removes member to playergroup" do
  	@pg1 = Playergroup.new(tournament_id: @t1.id)
  	@pg1.add_member(@u1)
  	@pg1.add_member(@u2)
  	@pg1.remove_member(@u3)
  	@pg1.add_member(@u3)
  	@pg1.remove_member(@u2)
  	@pg1.remove_member(@u4)
  	@pg1.save

  	assert_not @pg1.new_record?
  	assert @pg1.has_member?(@u1)
  	assert_not @pg1.has_member?(@u2)
  	assert @pg1.has_member?(@u3)
  	assert_not @pg1.has_member?(@u4)
  	assert_not @pg1.has_member?(@u5)
  end

  test "add invalid member to playergroup" do
  	@u4 = User.find_by(email: "b4@b4.com")
  	@u5 = User.find_by(email: "b5@b5.com")
  	@pg1 = Playergroup.new(tournament_id: @t1.id)

 	@wrong_user = User.new
 	@wrong_user.id=@u4.id+@u5.id
  	@pg1.add_member(@wrong_user)
  	@pg1.add_member(@u1)
  	@pg1.save
  	assert @pg1.new_record?
  end

  test "add_member function filters out duplicate members correctly" do
  	@u1 = User.find_by(email: "b1@b1.com")
  	@pg2 = Playergroup.new(tournament_id: @t1.id)

  	@pg2.add_member(@u1)
  	@pg2.add_member(@u1)
  	@pg2.save
  	assert_not @pg2.new_record?
  end

  test "model checks unique members before saving" do
  	@pg3 = Playergroup.new(tournament_id: @t1.id)
  	@pg3.group_members << @u1.id
  	@pg3.group_members << @u2.id
  	@pg3.group_members << @u1.id
  	@pg3.save
  	assert @pg3.new_record?
  end

  test "test correct number of members in playergroup" do
  	@pg1 = Playergroup.new(tournament_id: @t1.id)
  	@pg1.add_member(@u1)
  	@pg1.add_member(@u2)
  	@pg1.add_member(@u3)
  	@pg1.add_member(@u4)
  	@pg1.add_member(@u5)
  	@pg1.save
  	assert @pg1.new_record?
  end
end
