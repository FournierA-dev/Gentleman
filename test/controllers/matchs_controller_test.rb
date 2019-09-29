require 'test_helper'

class MatchsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get matchs_index_url
    assert_response :success
  end

  test "should get show" do
    get matchs_show_url
    assert_response :success
  end

  test "should get new" do
    get matchs_new_url
    assert_response :success
  end

  test "should get create" do
    get matchs_create_url
    assert_response :success
  end

  test "should get edit" do
    get matchs_edit_url
    assert_response :success
  end

  test "should get update" do
    get matchs_update_url
    assert_response :success
  end

  test "should get destroy" do
    get matchs_destroy_url
    assert_response :success
  end

end
