require 'test_helper'

class PlayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @e1 = Tournament.create(name: 'myTournament')
    #Tournament.find_by(id: 1)#Tournament.create(name: 'myTournament')
    @p1 = User.create(first_name: 'i', last_name: 'i', email: 'i@i.com', password:'1234567', password_confirmation:'1234567')
    #User.find_by(id: 2)
    #User.create(first_name: 'i', last_name: 'i', email: 'i@i.com', password:'1234567', password_confirmation:'1234567')
  	@involvement = Play.new(event_id: @e1.id, person_id: @p1.id)
  end

  test "play relation should be valid" do
  	assert @involvement.valid?
  end

  test "play relation should require event_id" do
  	@involvement.event_id = nil
  	assert_not @involvement.valid?
  end

  test "play relation should require person_id" do
  	@involvement.person_id = nil
  	assert_not @involvement.valid?
  end

  test "unique play event relation" do
    @involvement.save
    @i2 = Play.new(event_id:@e1.id, person_id: @p1.id)
    assert @i2.new_record?
  end
end
