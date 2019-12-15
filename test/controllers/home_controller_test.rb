require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
  end

  test "should get contact" do
    get contact_url
    assert_response :success

    assert_template layout: 'application'
  end

  test "should post request contact" do
    post request_contact_url, params: {name: "Foo", email: "foo@bar.com", message: "Hello"}
    assert_response :redirect
    assert_nil flash[:alert]
    assert_not_empty flash[:notice]
  end

  test "should post request contact but no email" do
    post request_contact_url

    assert_response :redirect
    assert_not_empty flash[:alert]
    assert_nil flash[:notice]
  end

end
