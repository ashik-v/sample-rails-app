require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example user", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end
 
 test "should be valid" do
   assert @user.valid?
 end
 
 test "name should be present" do
   @user.name = ""
   assert_not @user.valid?
 end
 
 test "email should be present" do
   @user.email = ""
   assert_not @user.valid?
 end
 
 test "name should not be too long" do
   @user.name = "a" * 51
   assert_not @user.valid?
 end
 
 test "email should not be too long" do
   @user.email = "a" * 244 + "@example.com"
   assert_not @user.valid?
 end
 
 test "email validation should accept valid emails" do
   valid_addresses = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.com]
   
   valid_addresses.each do |valid_address|
     @user.email = valid_address
     assert @user.valid?, "#{valid_address} should be valid"
   end
 end
 
 test "email validation should reject invalid emails" do
   invalid_addresses = %w[user@example,com user_at_foo.com user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
    @user.email = invalid_address
    assert_not @user.valid?, "#{invalid_address} should be invalid"
  end
 end
 
 test "email addresses should be unique" do
   duplicate_user = @user.dup
   @user.save
   assert_not duplicate_user.valid?
 end
 
 test "email addresses should be saved as lower-case" do
   mixed_case_email = "FoO@BaR.CoM"
   @user.email = mixed_case_email
   @user.save
   assert_equal mixed_case_email.downcase, @user.email
 end
 
 test "password should not be blank" do
   @user.password = @user.password_confirmation = " "
   assert_not @user.valid?
 end
 
 test "password should be at least 6 characters" do
  @user.password = @user.password_confirmation = "a" * 5
  assert_not @user.valid?
 end
 
 test "associated microposts should be destroyed" do
   @user.save
   @user.microposts.create!(content: "foobar")
   assert_difference 'Micropost.count', -1 do
     @user.destroy
   end
 end
end
