require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = User.new(first_name: "ExampleFirst", last_name: "ExampleLast", email: "user@example.com",
  		                    password: "foobar", password_confirmation: "foobar")
  end

  test "should be validate" do
  	assert @user.valid?
  end

  test "firstname should be present" do
  	@user.first_name = " "
  	assert_not @user.valid?
  end

  test "lastname should be present" do
    @user.last_name = " "
    assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = " "
  	assert_not @user.valid?
  end

  test "firstname should not be too long" do
    @user.first_name = "a" * 51
    assert_not @user.valid?
  end

  test "lastname should not be too long" do
    @user.last_name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

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

  test "should join(play in) and leave(not play) event" do
    @p1=User.create(first_name: 'join', last_name: 'join', email: 'join@join.com', password:'1234567', password_confirmation:'1234567')
    @e1=Tournament.create(name: 'myTournament')
    @p1.save
    @e1.save

    assert_not @p1.played_in?(@e1)
    assert_not @e1.got_player?(@p1)

    @p1.play_in(@e1)
    assert @p1.played_in?(@e1)
    assert @e1.got_player?(@p1)

    @p1.not_play(@e1)
    assert_not @p1.played_in?(@e1)
    assert_not @e1.got_player?(@p1)
    @p1.destroy
    @e1.destroy
  end
=end
end
