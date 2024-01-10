require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should find 1 B" do
    get search_index_url, params: { query: "b" }
    assert_response :success
    responce = @controller.instance_variable_get(:@results)
    assert_equal(1, responce[2].size)
  end

  test "should find 1 Common List" do
    get search_index_url, params: { query: "Lisp Common" }
    assert_response :success
    responce = @controller.instance_variable_get(:@results)
    assert_equal(1, responce[2].size)
  end

  test "should find Basic with Thomas Eugene" do
    get search_index_url, params: { query: "Thomas Eugene" }
    assert_response :success
    responce = @controller.instance_variable_get(:@results)
    assert_equal("basic", responce[2][0][:entry]['Name'])
    assert_equal(1, responce[2].size)
  end

  test "Find only 4 items with john -array" do
    get search_index_url, params: { query: "john -array" }
    assert_response :success
    responce = @controller.instance_variable_get(:@results)
    assert_equal(4, responce[1].size)
  end

end
