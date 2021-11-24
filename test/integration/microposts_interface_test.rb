require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ashik)
  end
  
  test "micropost interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'
    #invalid submission
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: " " } }
    end
    
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]', '/?page=2' #correct pagination link
    #valid submission
    content = "valid micropost"
    image = fixture_file_upload('test/fixtures/kitten.jpg', 'image/jpeg')
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: { content: content, image: image } }
    end
    assert_redirected_to root_url
    assert Micropost.first.image.attached?
    follow_redirect!
    assert_match content, response.body
    # delete post
    assert_select 'a', text: 'delete'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    # visit different user (no delete links)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
