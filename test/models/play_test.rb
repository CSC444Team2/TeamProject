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

  test "new records for play relation should work correctly" do
    @i2 = Play.new(event_id:@e1.id, person_id: @p1.id)
    assert @i2.new_record?
  end

  test "play relation should save successuflly" do
    @involvement.person_id = @e1.id
    @involvement.event_id = @p1.id
    @involvement.save
    assert_not @involvement.new_record?
  end

  test "play relation should link correctly with events" do
    @involvement.person_id = @e1.id
    @involvement.event_id = @p1.id
    @involvement.save
    assert @e1.got_player?(@p1)
  end

  test "play relation should link correctly with players" do
    @involvement.person_id = @e1.id
    @involvement.event_id = @p1.id
    @involvement.save
    assert @p1.played_in?(@e1)
  end
end
