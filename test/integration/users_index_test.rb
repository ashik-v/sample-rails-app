require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin_user = users(:ashik)
    @non_admin_user = users(:archer)
  end 
  
  test "index including pagination" do
    log_in_as(@admin_user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin_user
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin_user)
    end
  end
  
  test "index as non-admin" do
    log_in_as(@non_admin_user)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
