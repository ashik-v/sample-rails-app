require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:ashik).id,
                                     followed_id: users(:archer).id)
  end
  
  test "should be valid" do
    assert @relationship.valid?
  end
  
  test "should require a follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end
  
  test "should require a followed id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
  
  
  
  test "should follow and unfollow users" do
    ashik = users(:ashik)
    archer = users(:archer)
    assert_not ashik.following?(archer)
    ashik.follow(archer)
    assert ashik.following?(archer)
    assert archer.followers.include?(ashik)
    ashik.unfollow(archer)
   assert_not ashik.following?(archer)
  end
end
