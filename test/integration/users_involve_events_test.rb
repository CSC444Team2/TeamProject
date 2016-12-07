
require 'test_helper'

class UserInvolveEventsTest < ActiveSupport::TestCase

=begin
    def test_play(player, event, is_playing)
      if is_playing == true
        assert player.played_in?(event)
        assert event.got_player?(player)
      else
        assert_not player.played_in?(event)
        assert_not event.got_player?(player)
      end
    end
=end

    test "event relations" do
      @p1=User.create(first_name: 'join', last_name: 'join', email: 'join@join.com', password:'1234567', password_confirmation:'1234567')
      @e1=Tournament.create(name: 'myTournament')

      assert_not @p1.played_in?(@e1)
      assert_not @e1.got_player?(@p1)
      assert_not @p1.organized_a?(@e1)
      assert_not @e1.got_organizer?(@p1)
      assert_not @p1.sponsored_a?(@e1)
      assert_not @e1.got_organizer?(@p1)

      @p1.play_in(@e1)
      assert @p1.played_in?(@e1)
      assert @e1.got_player?(@p1)
      assert_not @p1.organized_a?(@e1)
      assert_not @e1.got_organizer?(@p1)
      assert_not @p1.sponsored_a?(@e1)
      assert_not @e1.got_sponsor?(@p1)

      @p1.organize_a(@e1)
      assert @p1.played_in?(@e1)
      assert @e1.got_player?(@p1)
      assert @p1.organized_a?(@e1)
      assert @e1.got_organizer?(@p1)
      assert_not @p1.sponsored_a?(@e1)
      assert_not @e1.got_sponsor?(@p1)


      @p1.not_play(@e1)
      assert_not @p1.played_in?(@e1)
      assert_not @e1.got_player?(@p1)

      @p1.not_sponsor(@e1)
      assert_not @p1.played_in?(@e1)
      assert_not @e1.got_player?(@p1)
      assert @p1.organized_a?(@e1)
      assert @e1.got_organizer?(@p1)
      assert_not @p1.sponsored_a?(@e1)
      assert_not @e1.got_sponsor?(@p1)

      @p1.sponsor_a(@e1)
      assert_not @p1.played_in?(@e1)
      assert_not @e1.got_player?(@p1)
      assert @p1.organized_a?(@e1)
      assert @e1.got_organizer?(@p1)
      assert @p1.sponsored_a?(@e1)
      assert @e1.got_sponsor?(@p1)


      #@p1.destroy
      #@e1.destroy
    end
end