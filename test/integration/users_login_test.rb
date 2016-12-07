require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
  end

  test "login with valid info" do
    @u1 = User.create(first_name: "Firrrrrst", last_name: "Lassst", email: "u1@example.com",
                          password: "blah12345", password_confirmation: "blah12345")
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "u1@example.com", password: "blah12345" } }
    assert_redirected_to user_path(@u1)
    assert flash.empty?
  end
end
